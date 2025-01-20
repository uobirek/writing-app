import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import '../models/project.dart';

class ProjectRepository {
  final FirebaseFirestore _firestore;

  // Cloudinary configuration
  final String cloudName =
      "do1dcq82t"; // Replace with your Cloudinary Cloud Name
  final String uploadPreset =
      "flutter_notes_upload"; // Replace with your Cloudinary Upload Preset

  ProjectRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Upload image to Cloudinary
  Future<String> uploadImageToCloudinary(File imageFile) async {
    try {
      final String uploadUrl =
          "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(imageFile.path),
        "upload_preset": uploadPreset,
      });

      final response = await Dio().post(uploadUrl, data: formData);

      if (response.statusCode == 200) {
        return response.data["secure_url"]; // Return the Cloudinary URL
      } else {
        throw Exception("Failed to upload image: ${response.data}");
      }
    } catch (e) {
      print('Error uploading image to Cloudinary: $e');
      rethrow;
    }
  }

  /// Delete image from Cloudinary
  Future<void> deleteImageFromCloudinary(String imageUrl) async {
    try {
      final String publicId = imageUrl
          .split('/')
          .last
          .split('.')
          .first; // Extract public ID from URL
      final String deleteUrl =
          "https://api.cloudinary.com/v1_1/$cloudName/delete_by_token";

      final response =
          await Dio().post(deleteUrl, data: {"public_id": publicId});

      if (response.statusCode == 200) {
        print("Image deleted successfully");
      } else {
        throw Exception("Failed to delete image: ${response.data}");
      }
    } catch (e) {
      print('Error deleting image from Cloudinary: $e');
      rethrow;
    }
  }

  /// Fetch all projects
  Future<List<Project>> fetchAllProjects(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .get();

      if (snapshot.docs.isEmpty) {
        print('No projects found for userId: $userId');
        return [];
      }

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Project.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error fetching projects: $e');
      throw Exception('Failed to fetch projects: $e');
    }
  }

  /// Add new project with optional image
  Future<Project> addProject(
      Project project, String userId, File? imageFile) async {
    try {
      String? imageUrl;
      if (imageFile != null) {
        imageUrl = await uploadImageToCloudinary(imageFile);
      }

      final docRef = await _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .add({
        ...project.toJson(),
        'imageUrl': imageUrl, // Store image URL
      });

      await docRef.update({'id': docRef.id});
      return project.copyWith(id: docRef.id, imageUrl: imageUrl);
    } catch (e) {
      throw Exception('Failed to add project: $e');
    }
  }

  /// Update project with optional new image
  Future<void> updateProject(
      Project project, String userId, File? imageFile) async {
    try {
      String? imageUrl = project.imageUrl;

      if (imageFile != null) {
        // Delete the old image if one exists
        if (imageUrl != null) {
          await deleteImageFromCloudinary(imageUrl);
        }

        // Upload the new image to Cloudinary
        imageUrl = await uploadImageToCloudinary(imageFile);
      }

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .doc(project.id)
          .update({
        ...project.toJson(),
        'imageUrl': imageUrl, // Update image URL if a new one is uploaded
      });
    } catch (e) {
      throw Exception('Failed to update project: $e');
    }
  }

  /// Delete project and its associated image
  Future<void> deleteProject(String projectId, String userId) async {
    try {
      final projectRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .doc(projectId);

      final projectData = await projectRef.get();

      if (projectData.exists) {
        final imageUrl = projectData.data()?['imageUrl'];
        if (imageUrl != null) {
          await deleteImageFromCloudinary(imageUrl); // Delete image if exists
        }

        await projectRef.delete(); // Delete the project
      }
    } catch (e) {
      throw Exception('Failed to delete project: $e');
    }
  }

  /// Fetch a project by its ID
  Future<Project?> getProjectById(String projectId, String userId) async {
    try {
      final projectRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .doc(projectId);

      final projectSnapshot = await projectRef.get();

      if (projectSnapshot.exists) {
        final data = projectSnapshot.data();
        return Project.fromJson(
            data!); // Assuming Project has a fromJson constructor
      } else {
        print('Project not found for projectId: $projectId');
        return null; // Return null if project is not found
      }
    } catch (e) {
      print('Error fetching project by ID: $e');
      rethrow; // Rethrow exception
    }
  }
}
