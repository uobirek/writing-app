import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/editing/note_editing.dart';
import 'package:writing_app/screens/notes/models/simple_note.dart';
import 'package:writing_app/widgets/custom_text_field.dart';

class SimpleNoteEditing extends NoteEditing {
  SimpleNoteEditing(this.note) : super(note.imageUrl) {
    titleController = TextEditingController(text: note.title);
    contentController = TextEditingController(text: note.specialData);
  }
  final SimpleNote note;
  late TextEditingController titleController;
  late TextEditingController contentController;

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
            const SizedBox(height: 16),
            buildImageField(context), // Use default image field here
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
      imageUrl: imagePath ?? 'assets/images/placeholder.png',
    );
  }
}
