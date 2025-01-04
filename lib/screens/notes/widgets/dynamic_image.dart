import 'dart:io';

import 'package:flutter/material.dart';

class DynamicImageWidget extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const DynamicImageWidget({
    Key? key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imagePath.startsWith('assets/')) {
      // Asset image
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Image.asset(
          imagePath,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image,
                size: 140); // Handle missing asset
          },
        ),
      );
    } else {
      // Local file image
      final file = File(imagePath);
      if (file.existsSync()) {
        return ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.zero,
          child: Image.file(
            file,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image,
                  size: 140); // Handle missing file
            },
          ),
        );
      } else {
        return const Icon(Icons.broken_image,
            size: 140); // Handle missing file gracefully
      }
    }
  }
}
