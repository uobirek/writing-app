import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:writing_app/features/notes/models/note.dart';
import 'package:writing_app/features/notes/save_image.dart';
import 'package:writing_app/features/notes/widgets/dynamic_image.dart';

abstract class NoteEditing {
  NoteEditing(String? initialImage) {
    imagePath = initialImage;
    if (initialImage != null && !initialImage.startsWith('http')) {
      selectedImage = File(initialImage);
    }
  }
  String? imagePath;
  File? selectedImage;
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
            imagePath: imagePath ?? '',
            width: 150,
            height: 150,
            borderRadius: BorderRadius.circular(8),
          ),
          if (_isHovered)
            AnimatedOpacity(
              opacity: 0.5,
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
