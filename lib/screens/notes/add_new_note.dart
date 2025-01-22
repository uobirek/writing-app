import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/models/project_cubit.dart';
import 'package:writing_app/screens/notes/bloc/note_cubit.dart';
import 'package:writing_app/screens/notes/bloc/note_state.dart';
import 'package:writing_app/screens/notes/create_a_blank_note.dart';
import 'package:writing_app/screens/notes/editing/note_editing.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  late NoteEditing noteEditing;
  final _formKey = GlobalKey<FormState>();
  String _selectedNoteType = 'SimpleNote';
  bool _isLoading = true; // To track loading state while creating a blank note

  @override
  void initState() {
    super.initState();
    _initializeNoteDetailsUI();
  }

  Future<void> _initializeNoteDetailsUI() async {
    setState(() {
      _isLoading = true; // Show loading state
    });

    final blankNote = await createBlankNote(
      _selectedNoteType,
      context.read<NoteCubit>().allNotes,
    );

    setState(() {
      noteEditing = blankNote.getNoteEditing();
      _isLoading = false; // Hide loading state
    });
  }

  void _onNoteTypeChanged(String? newType) {
    if (newType != null && newType != _selectedNoteType) {
      setState(() {
        _selectedNoteType = newType;
      });
      _initializeNoteDetailsUI(); // Reinitialize with the new note type
    }
  }

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      // Update the note with image path
      final newNote = noteEditing.buildUpdatedNote();
      final projectCubit = context.read<ProjectCubit>();
      final project = projectCubit.selectedProject;

      // Use the NoteCubit to add the note
      context
          .read<NoteCubit>()
          .addNote(newNote, noteEditing.selectedImage, project!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteCubit, NoteState>(
      listener: (context, state) {
        if (state is NoteError) {
          // Show an error message if the note addition fails
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is NoteLoaded) {
          // Navigate back to the notes list on successful addition
          context.go('/notes');
        }
      },
      child: SidebarLayout(
        activeRoute: '/notes',
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Add New Note'),
            actions: [
              IconButton(
                icon: const Icon(Icons.save),
                onPressed:
                    _isLoading ? null : _saveNote, // Disable save while loading
              ),
            ],
          ),
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonFormField<String>(
                        value: _selectedNoteType,
                        items: const [
                          DropdownMenuItem(
                              value: 'SimpleNote', child: Text('Simple Note')),
                          DropdownMenuItem(
                              value: 'CharacterNote',
                              child: Text('Character Note')),
                          DropdownMenuItem(
                              value: 'WorldbuildingNote',
                              child: Text('Worldbuilding Note')),
                        ],
                        onChanged: _onNoteTypeChanged,
                        decoration: const InputDecoration(
                            labelText: 'Select Note Type'),
                      ),
                      const SizedBox(height: 16),
                      const SizedBox(height: 16),
                      Expanded(
                        child: SingleChildScrollView(
                          child:
                              noteEditing.buildDetailsForm(_formKey, context),
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
