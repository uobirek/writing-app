import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/features/notes/cubit/note_cubit.dart';
import 'package:writing_app/features/notes/cubit/note_state.dart';
import 'package:writing_app/features/notes/models/note.dart';
import 'package:writing_app/features/notes/screens/editing/note_editing.dart';
import 'package:writing_app/features/projects/cubit/project_cubit.dart';
import 'package:writing_app/l10n/app_localizations.dart';
import 'package:writing_app/utils/scaffold_messenger.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key, required this.noteId});
  final String noteId;

  @override
  EditNoteScreenState createState() => EditNoteScreenState();
}

class EditNoteScreenState extends State<EditNoteScreen> {
  late NoteEditing noteEditing;
  final _formKey = GlobalKey<FormState>();
  Note? currentNote;

  @override
  void initState() {
    super.initState();
    final noteCubit = context.read<NoteCubit>();
    final note = noteCubit.getNoteById(widget.noteId);
    if (note != null) {
      currentNote = note;
      noteEditing = note.getNoteEditing();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return SafeArea(
      child: BlocListener<NoteCubit, NoteState>(
        listener: (context, state) {
          if (state is NoteError) {
            showMessage(context, state.message);
          }
        },
        child: SidebarLayout(
          activeRoute: '/notes',
          child: currentNote == null
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: _isMobile()
                      ? const EdgeInsets.symmetric(horizontal: 10, vertical: 15)
                      : const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 30,
                        ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 30,
                          spreadRadius: 6,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            noteEditing.buildDetailsForm(_formKey, context),
                            const SizedBox(height: 16),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final updatedNote =
                                        noteEditing.buildUpdatedNote();
                                    final projectCubit =
                                        context.read<ProjectCubit>();
                                    final project =
                                        projectCubit.selectedProject;

                                    await context.read<NoteCubit>().updateNote(
                                          updatedNote,
                                          noteEditing.selectedImage,
                                          project!.id,
                                        );
                                    showMessage(
                                      context,
                                      'Note saved succesfully',
                                    );

                                    context.go('/notes');
                                  }
                                },
                                child: Text(localizations!.saveChanges),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

bool _isMobile() {
  return Platform.isAndroid || Platform.isIOS;
}
