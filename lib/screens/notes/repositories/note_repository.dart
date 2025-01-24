import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import '../models/character_note.dart';
import '../models/note.dart';
import '../models/worldbuilding_note.dart';

class NoteRepository {
  // Replace with your Cloudinary Upload Preset

  NoteRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;
  final FirebaseFirestore _firestore;

  // Cloudinary configuration
  final String cloudName =
      'do1dcq82t'; // Replace with your Cloudinary Cloud Name
  final String uploadPreset = 'flutter_notes_upload';

  /// Upload image to Cloudinary
  Future<String?> uploadImageToCloudinary(File imageFile) async {
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
        return responseData['secure_url'] as String?;
      } else {
        throw Exception('Failed to upload image: ${response.data}');
      }
    } catch (err) {
      rethrow;
    }
  }

  /// Delete image from Cloudinary
  Future<void> deleteImageFromCloudinary(String imageUrl) async {
    // Function implementation remains as is.
  }

  /// Add a new note with optional image
  Future<void> addNote(
    Note note,
    File? imageFile,
    String userId,
    String projectId,
  ) async {
    try {
      String? imageUrl;

      if (imageFile != null) {
        imageUrl = await uploadImageToCloudinary(imageFile);
      }

      // Add note to Firestore under the user's collection
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .doc(projectId)
          .collection('notes')
          .add({
        ...note.toJson(),
        'imageUrl': imageUrl,
        'userId': userId, // Ensure the note is tied to the user
      });
    } catch (err) {
      rethrow;
    }
  }

  /// Update an existing note with optional image
  Future<void> updateNote(
    Note note,
    File? imageFile,
    String userId,
    String projectId,
  ) async {
    try {
      String? imageUrl = note.imageUrl;

      if (imageFile != null) {
        // Delete the old image if one exists
        if (imageUrl != null) {
          await deleteImageFromCloudinary(imageUrl);
        }

        // Upload the new image to Cloudinary
        imageUrl = await uploadImageToCloudinary(imageFile);
      }

      // Update note in Firestore
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .doc(projectId)
          .collection('notes')
          .doc(note.id)
          .update({
        ...note.toJson(),
        'imageUrl': imageUrl, // Update image URL if a new image is uploaded
      });
    } catch (err) {
      rethrow;
    }
  }

  /// Delete note and its associated image
  Future<void> deleteNoteById(
    String noteId,
    String userId,
    String projectId,
  ) async {
    try {
      final noteRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .doc(projectId)
          .collection('notes')
          .doc(noteId);

      final noteData = await noteRef.get();

      if (noteData.exists) {
        final imageUrl =
            noteData.data()?['imageUrl'] as String?; // Cast to String?
        if (imageUrl != null) {
          await deleteImageFromCloudinary(imageUrl); // Delete the image
        }

        await noteRef.delete(); // Delete the note
      }
    } catch (err) {
      rethrow;
    }
  }

  /// Fetch all notes from Firestore
  Future<List<Note>> fetchAllNotes(String userId, String projectId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .doc(projectId)
          .collection('notes')
          .orderBy('position') // Order notes by 'position'
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return _mapJsonToNote(data, doc.id);
      }).toList();
    } catch (err) {
      rethrow;
    }
  }

  Future<List<Note>> fetchNotesByCategory(
    String userId,
    String category,
    String projectId,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .doc(projectId)
          .collection('notes')
          .where('category', isEqualTo: category)
          .orderBy('position')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return _mapJsonToNote(data, doc.id);
      }).toList();
    } catch (err) {
      rethrow;
    }
  }

  Future<int> getNextPosition(String userId, String projectId) async {
    try {
      // Query Firestore to get the note with the highest position
      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .doc(projectId)
          .collection('notes')
          .orderBy('position', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Safely extract and cast the highest position from the document
        return (querySnapshot.docs.first['position'] as int?) ?? 0 + 1;
      } else {
        // If no notes exist, start from position 0
        return 0;
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<void> updateNoteOrder(
    List<Note> reorderedNotes,
    String userId,
    String projectId,
  ) async {
    final batch = _firestore.batch();

    for (int i = 0; i < reorderedNotes.length; i++) {
      final note = reorderedNotes[i];
      final noteRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .doc(projectId)
          .collection('notes')
          .doc(note.id);

      batch.update(noteRef, {
        'position': i,
      }); // Assuming "position" is the field that tracks order
    }

    try {
      await batch.commit(); // Perform all updates in a batch
    } catch (err) {
      rethrow;
    }
  }

  /// Helper function to map JSON data to a Note object
  Note _mapJsonToNote(Map<String, dynamic> data, String id) {
    final type = data['type'];
    data['id'] = id; // Include document ID in the data

    if (type == 'CharacterNote') {
      return CharacterNote.fromJson(data);
    } else if (type == 'WorldbuildingNote') {
      return WorldbuildingNote.fromJson(data);
    } else {
      throw Exception('Unknown note type: $type');
    }
  }

  Future<Note?> getNoteById(
    String noteId,
    String userId,
    String projectId,
  ) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .doc(projectId)
          .collection('notes')
          .doc(noteId)
          .get();
      if (doc.exists) {
        return Note.fromJson(doc.data()!);
      }
      return null;
    } catch (err) {
      rethrow;
    }
  }
}
