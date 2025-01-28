import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import '../models/project.dart';

class ProjectRepository {
  ProjectRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;
  final FirebaseFirestore _firestore;

  // Cloudinary configuration
  final String cloudName =
      'do1dcq82t'; // Replace with your Cloudinary Cloud Name
  final String uploadPreset =
      'flutter_notes_upload'; // Replace with your Cloudinary preset

  Future<String> uploadImageToCloudinary(File imageFile) async {
    try {
      final uploadUrl =
          'https://api.cloudinary.com/v1_1/$cloudName/image/upload';

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path),
        'upload_preset': uploadPreset,
      });

      final response = await Dio().post(uploadUrl, data: formData);

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        return responseData['secure_url'] as String;
      } else {
        throw Exception(
          'Cloudinary upload failed',
        );
      }
    } catch (err) {
      throw Exception('Failed to upload image to Cloudinary: $err');
    }
  }

  Future<void> deleteImageFromCloudinary(String imageUrl) async {
    try {
      final String publicId = imageUrl.split('/').last.split('.').first;
      final deleteUrl =
          'https://api.cloudinary.com/v1_1/$cloudName/delete_by_token';

      final response =
          await Dio().post(deleteUrl, data: {'public_id': publicId});

      if (response.statusCode != 200) {
        throw Exception(
          'Cloudinary delete failed: ${response.data['error'] ?? response.data}',
        );
      }
    } catch (err) {
      throw Exception('Failed to delete image from Cloudinary: $err');
    }
  }

  Future<List<Project>> fetchAllProjects(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .get();

      if (snapshot.docs.isEmpty) {
        throw Exception('No projects found for userId: $userId');
      }

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Project.fromJson(data);
      }).toList();
    } catch (err) {
      throw Exception('Failed to fetch projects: $err');
    }
  }

  Future<Project> addProject(
    Project project,
    String userId,
    File? imageFile,
  ) async {
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
        'imageUrl': imageUrl,
      });

      await docRef.update({'id': docRef.id});
      return project.copyWith(id: docRef.id, imageUrl: imageUrl);
    } catch (err) {
      throw Exception('Failed to add project: $err');
    }
  }

  Future<void> updateProject(
    Project project,
    String userId,
    File? imageFile,
  ) async {
    try {
      String? imageUrl = project.imageUrl;

      if (imageFile != null) {
        imageUrl = await uploadImageToCloudinary(imageFile);
      }

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .doc(project.id)
          .update({
        ...project.toJson(),
        'imageUrl': imageUrl,
      });
    } catch (err) {
      throw Exception('Failed to update project: $err');
    }
  }

  Future<void> deleteProject(String projectId, String userId) async {
    try {
      final projectRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .doc(projectId);

      final projectData = await projectRef.get();

      if (projectData.exists) {
        await projectRef.delete();
      } else {
        throw Exception('Project not found for ID: $projectId');
      }
    } catch (err) {
      throw Exception('Failed to delete project: $err');
    }
  }

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
        return Project.fromJson(data!);
      } else {
        throw Exception('Project not found for ID: $projectId');
      }
    } catch (err) {
      throw Exception('Failed to fetch project by ID: $err');
    }
  }
}
