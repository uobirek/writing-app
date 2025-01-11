import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/screens/notes/bloc/note_cubit.dart';
import 'package:writing_app/screens/notes/bloc/note_state.dart';
import 'package:writing_app/screens/notes/editing/note_editing.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class EditNoteScreen extends StatefulWidget {
  final String noteId;

  const EditNoteScreen({super.key, required this.noteId});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late NoteEditing noteEditing;
  final _formKey = GlobalKey<FormState>();
  Note? currentNote;

  @override
  void initState() {
    super.initState();
    // Fetch the note using the Bloc
    final noteCubit = context.read<NoteCubit>();
    final note = noteCubit.getNoteById(widget.noteId); // Fetch the note by ID
    if (note != null) {
      currentNote = note;
      noteEditing = note.getNoteEditing();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteCubit, NoteState>(
      listener: (context, state) {
        if (state is NoteError) {
          // Handle errors
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is NoteLoaded) {
          // Navigate back to notes screen after a successful update
          context.go('/notes');
        }
      },
      child: SidebarLayout(
        activeRoute: '/notes',
        child: currentNote == null
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 30,
                        spreadRadius: 6,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),

                          // Render dynamic form fields
                          noteEditing.buildDetailsForm(_formKey, context),

                          const SizedBox(height: 16),

                          // Submit button
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final updatedNote =
                                      noteEditing.buildUpdatedNote();

                                  // Use the NoteCubit to add the note
                                  context.read<NoteCubit>().updateNote(
                                        updatedNote,
                                        noteEditing
                                            .selectedImage, // Pass the selected image file
                                        "1", // Replace with actual user ID
                                      );
                                }
                              },
                              child: const Text("Save Changes"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
