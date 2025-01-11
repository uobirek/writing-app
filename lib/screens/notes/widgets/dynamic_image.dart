import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DynamicImageWidget extends StatelessWidget {
  final String? imagePath; // Local path or remote Cloudinary URL
  final double? width; // Desired width of the image
  final double? height; // Desired height of the image
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const DynamicImageWidget({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath == null || imagePath!.isEmpty) {
      // Handle null or empty image paths gracefully
      return _buildPlaceholder();
    }

    if (imagePath!.startsWith('http')) {
      // Cloudinary or other remote image (URL)
      final optimizedUrl = _getOptimizedCloudinaryUrl(imagePath!);
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: CachedNetworkImage(
          imageUrl: optimizedUrl,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) =>
              _buildLoadingPlaceholder(), // Show loading indicator
          errorWidget: (context, url, error) =>
              _buildPlaceholder(), // Handle broken URL
        ),
      );
    } else if (imagePath!.startsWith('assets/')) {
      // Asset image
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Image.asset(
          imagePath!,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholder(); // Handle missing asset
          },
        ),
      );
    } else {
      // Local file image
      final file = File(imagePath!);
      if (file.existsSync()) {
        return ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.zero,
          child: Image.file(
            file,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (context, error, stackTrace) {
              return _buildPlaceholder(); // Handle broken image
            },
          ),
        );
      } else {
        // File does not exist
        return _buildPlaceholder();
      }
    }
  }

  /// Optimize Cloudinary URL with transformations
  String _getOptimizedCloudinaryUrl(String url) {
    // Example Cloudinary transformation: Resize to width & height
    // Add transformations like 'w_200,h_200,c_fill' in the URL
    final transformation =
        'c_fill'; // Use BoxFit.cover equivalent transformation
    final widthParam = width != null ? 'w_${width!.toInt()}' : '';
    final heightParam = height != null ? 'h_${height!.toInt()}' : '';

    final transformationParams = [widthParam, heightParam, transformation]
        .where((param) => param.isNotEmpty)
        .join(',');

    // Insert transformation into the Cloudinary URL
    if (url.contains('/upload/')) {
      return url.replaceFirst('/upload/', '/upload/$transformationParams/');
    }

    return url; // Return unmodified if not a valid Cloudinary URL
  }

  /// Builds a placeholder widget for missing or invalid images
  Widget _buildPlaceholder() {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Container(
        width: width ?? 140,
        height: height ?? 140,
        color: Colors.grey[300],
        child: const Icon(
          Icons.broken_image,
          size: 50,
          color: Colors.grey,
        ),
      ),
    );
  }

  /// Builds a loading placeholder while the remote image is fetched
  Widget _buildLoadingPlaceholder() {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Container(
        width: width ?? 140,
        height: height ?? 140,
        color: Colors.grey[200],
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
