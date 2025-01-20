import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/save_image.dart';

abstract class NoteEditing {
  String? imagePath;
  File? selectedImage; // Stores the selected image file

  NoteEditing(String? initialImage) {
    imagePath = initialImage;
  }

  Widget buildDetailsForm(GlobalKey<FormState> formKey, BuildContext context);

  Note buildUpdatedNote();

  /// Picks an image using the ImagePicker and saves it to the local directory.
  /// Updates the `imageController` with the new path.
  Future<void> pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final savedPath = await saveImageToLocalDirectory(File(image.path));
      selectedImage = File(savedPath); // Update the selected image
      imagePath = savedPath; // Update the controller with the new path

      // Trigger UI update
      (context as Element).markNeedsBuild();
    }
  }

  /// Builds the image field with a preview, pick button, and path display.
  Widget buildImageField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Image:'),
        const SizedBox(height: 8),
        if (selectedImage != null) // Display the selected image if available
          Image.file(
            selectedImage!,
            height: 150,
            width: 150,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Text('Error loading image');
            },
          ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            await pickImage(context);
            // Rebuild the UI to reflect the selected image
            (context as Element).markNeedsBuild();
          },
          child: const Text('Pick Image'),
        ),
        const SizedBox(height: 8),
        Text(imagePath ?? 'no image',
            style: Theme.of(context).textTheme.labelSmall)
      ],
    );
  }
}
