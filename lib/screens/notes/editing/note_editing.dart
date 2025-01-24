import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/save_image.dart';
import 'package:writing_app/screens/notes/widgets/dynamic_image.dart';

abstract class NoteEditing {
  // Track hover state

  NoteEditing(String? initialImage) {
    imagePath = initialImage;
    if (initialImage != null && !initialImage.startsWith('http')) {
      // Only treat as a local file path if it's not a URL
      selectedImage = File(initialImage);
    }
  }
  String? imagePath;
  File? selectedImage; // Stores the selected image file
  bool _isHovered = false;

  Widget buildDetailsForm(GlobalKey<FormState> formKey, BuildContext context);

  Note buildUpdatedNote();

  Future<void> pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final savedPath = await saveImageToLocalDirectory(File(image.path));
      selectedImage = File(savedPath);
      imagePath = savedPath;

      // Trigger UI update
      (context as Element).markNeedsBuild();
    }
  }

  Widget buildImageField(BuildContext context) {
    return InkWell(
      onTap: () async {
        await pickImage(context);
        (context as Element).markNeedsBuild();
      },
      onHover: (isHovering) {
        _isHovered = isHovering;
        (context as Element).markNeedsBuild();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          DynamicImageWidget(
            imagePath: imagePath ?? '', // Use imagePath (could be a URL)
            width: 150,
            height: 150,
            borderRadius: BorderRadius.circular(8),
          ),
          if (_isHovered)
            AnimatedOpacity(
              opacity: 0.5, // Show dark overlay on hover
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: 150,
                height: 150,
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ),
          if (_isHovered)
            const Icon(
              Icons.camera_alt,
              size: 40,
              color: Colors.white,
            ),
        ],
      ),
    );
  }
}
