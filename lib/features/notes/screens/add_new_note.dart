import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/features/notes/cubit/note_cubit.dart';
import 'package:writing_app/features/notes/cubit/note_state.dart';
import 'package:writing_app/features/notes/screens/create_a_blank_note.dart';
import 'package:writing_app/features/notes/screens/editing/note_editing.dart';
import 'package:writing_app/features/projects/cubit/project_cubit.dart';
import 'package:writing_app/l10n/app_localizations.dart';
import 'package:writing_app/utils/scaffold_messenger.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  AddNoteScreenState createState() => AddNoteScreenState();
}

class AddNoteScreenState extends State<AddNoteScreen> {
  late NoteEditing noteEditing;
  final _formKey = GlobalKey<FormState>();
  String _selectedNoteType = 'WorldbuildingNote';
  bool _isLoading = true;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      _initializeNoteDetailsUI();
      _initialized = true;
    }
  }

  Future<void> _initializeNoteDetailsUI() async {
    setState(() {
      _isLoading = true;
    });

    final blankNote = await createBlankNote(
      _selectedNoteType,
      context.read<NoteCubit>().allNotes,
      context,
    );

    setState(() {
      noteEditing = blankNote.getNoteEditing();
      _isLoading = false;
    });
  }

  void _onNoteTypeChanged(String? newType) {
    if (newType != null && newType != _selectedNoteType) {
      setState(() {
        _selectedNoteType = newType;
      });
      _initializeNoteDetailsUI();
    }
  }

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      final newNote = noteEditing.buildUpdatedNote();
      final projectCubit = context.read<ProjectCubit>();
      final project = projectCubit.selectedProject;

      context
          .read<NoteCubit>()
          .addNote(newNote, noteEditing.selectedImage, project!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return BlocListener<NoteCubit, NoteState>(
      listener: (context, state) {
        if (state is NoteError) {
          showMessage(context, state.message);
        } else if (state is NoteLoaded) {
          context.go('/notes');
        }
      },
      child: SidebarLayout(
        activeRoute: '/notes',
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              localizations!.addNewNote,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonFormField<String>(
                        value: _selectedNoteType,
                        items: [
                          DropdownMenuItem(
                            value: 'OutlineNote',
                            child: Text(
                              'Outline',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'CharacterNote',
                            child: Text(
                              localizations.characterNote,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'WorldbuildingNote',
                            child: Text(
                              localizations.worldbuildingNote,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ],
                        onChanged: _onNoteTypeChanged,
                        decoration: InputDecoration(
                          labelText: localizations.selectNoteType,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const SizedBox(height: 16),
                      Expanded(
                        child: SingleChildScrollView(
                          child:
                              noteEditing.buildDetailsForm(_formKey, context),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                          ),
                          onPressed: _saveNote,
                          child: Text(localizations.saveChanges),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
