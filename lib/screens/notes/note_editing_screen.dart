import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/data/notes_data.dart';
import 'package:writing_app/screens/notes/editing/character_note_editing.dart';
import 'package:writing_app/screens/notes/editing/note_editing.dart';
import 'package:writing_app/screens/notes/editing/simple_note_editing.dart';
import 'package:writing_app/screens/notes/models/character_note.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/models/simple_note.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class EditNoteScreen extends StatefulWidget {
  final Note note;

  const EditNoteScreen({super.key, required this.note});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late NoteEditing noteEditing;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    noteEditing = widget.note.getNoteEditing();
  }

// W _EditNoteScreenState
  @override
  Widget build(BuildContext context) {
    return SidebarLayout(
      activeRoute: '/notes',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 30,
                spreadRadius: 6,
              )
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // Render dynamic form fields
                noteEditing.buildDetailsForm(_formKey, context),

                const SizedBox(height: 16),

                // Submit button
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        return Theme.of(context).colorScheme.secondary;
                      },
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final updatedNote = noteEditing.buildUpdatedNote();
                      // Update the notes data
                      notes.remove(widget.note);
                      notes.add(updatedNote);
                      context.go('/notes');
                    }
                  },
                  child: const Text("Save Changes"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
