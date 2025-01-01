import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/editing/note_editing.dart';
import 'package:writing_app/screens/notes/models/simple_note.dart';
import 'package:writing_app/screens/notes/widgets/custom_text_field.dart';

class SimpleNoteEditing implements NoteEditing {
  final SimpleNote note;
  late TextEditingController titleController;
  late TextEditingController contentController;

  SimpleNoteEditing(this.note) {
    titleController = TextEditingController(text: note.title);
    contentController = TextEditingController(text: note.specialData);
  }

  @override
  Widget buildDetailsForm(GlobalKey<FormState> formKey, BuildContext context) {
    return SizedBox(
      width: 200,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(controller: titleController, label: 'Title'),
            CustomTextField(controller: contentController, label: 'Content'),
          ],
        ),
      ),
    );
  }

  @override
  SimpleNote buildUpdatedNote() {
    return SimpleNote(
      contentController.text,
      id: note.id,
      createdAt: note.createdAt,
      title: titleController.text,
      image: note.image,
    );
  }
}
