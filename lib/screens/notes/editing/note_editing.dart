import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/models/note.dart';

abstract class NoteEditing {
  final TextEditingController imageController = TextEditingController();

  NoteEditing(String? initialImage) {
    imageController.text = initialImage ?? '';
  }

  Widget buildDetailsForm(GlobalKey<FormState> formKey, BuildContext context);

  Note buildUpdatedNote();

  Widget buildImageField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Image:'),
        const SizedBox(height: 8),
        TextFormField(
          controller: imageController,
          decoration: const InputDecoration(
            labelText: 'Image URL',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
