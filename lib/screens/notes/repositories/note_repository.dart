import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import '../models/note.dart';
import '../models/character_note.dart';
import '../models/worldbuilding_note.dart';

class NoteRepository {
  final FirebaseFirestore _firestore;

  // Cloudinary configuration
  final String cloudName =
      "do1dcq82t"; // Replace with your Cloudinary Cloud Name
  final String uploadPreset =
      "flutter_notes_upload"; // Replace with your Cloudinary Upload Preset

  NoteRepository({FirebaseFirestore? firestore})
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
  Future<void> deleteImageFromCloudinary(String imageUrl) async {}

  /// Add a new note with optional image
  Future<void> addNote(Note note, File? imageFile, String userId) async {
    try {
      String? imageUrl;

      if (imageFile != null) {
        // Upload image to Cloudinary
        imageUrl = await uploadImageToCloudinary(imageFile);
      }

      // Add note to Firestore
      await _firestore.collection('notes').add({
        ...note.toJson(),
        'imageUrl': imageUrl, // Add image URL if available
      });
    } catch (e) {
      print('Error adding note: $e');
      rethrow;
    }
  }

  /// Update an existing note with optional image
  Future<void> updateNote(Note note, File? imageFile, String userId) async {
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
      await _firestore.collection('notes').doc(note.id).update({
        ...note.toJson(),
        'imageUrl': imageUrl, // Update image URL if a new image is uploaded
      });
    } catch (e) {
      print('Error updating note: $e');
      rethrow;
    }
  }

  /// Delete note and its associated image
  Future<void> deleteNoteById(String noteId, String userId) async {
    try {
      final noteRef = _firestore.collection('notes').doc(noteId);
      final noteData = await noteRef.get();

      if (noteData.exists) {
        final imageUrl = noteData.data()?['imageUrl'];

        if (imageUrl != null) {
          await deleteImageFromCloudinary(imageUrl); // Delete associated image
        }

        await noteRef.delete(); // Delete the note itself
      }
    } catch (e) {
      print('Error deleting note: $e');
      rethrow;
    }
  }

  /// Fetch all notes from Firestore
  Future<List<Note>> fetchAllNotes() async {
    try {
      final snapshot = await _firestore
          .collection('notes')
          .orderBy(
              'position') // Order by the 'position' field to get notes in the correct order
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return _mapJsonToNote(data, doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching notes: $e');
      rethrow;
    }
  }

  Future<List<Note>> fetchNotesByCategory(String category) async {
    try {
      final snapshot = await _firestore
          .collection('notes')
          .where('category', isEqualTo: category)
          .orderBy('position') // Ensure they are ordered by 'position' field
          .get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return _mapJsonToNote(data, doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching notes by category: $e');
      rethrow;
    }
  }

  Future<int> getNextPosition() async {
    try {
      // Query Firestore to get the note with the highest position
      final querySnapshot = await _firestore
          .collection('notes')
          .orderBy('position', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Extract the highest position from the document
        return querySnapshot.docs.first['position'] + 1;
      } else {
        // If no notes exist, start from position 0
        return 0;
      }
    } catch (e) {
      print("Error getting next position: $e");
      rethrow;
    }
  }

  Future<void> updateNoteOrder(List<Note> reorderedNotes) async {
    final batch = _firestore.batch();

    for (int i = 0; i < reorderedNotes.length; i++) {
      final note = reorderedNotes[i];
      final noteRef = _firestore.collection('notes').doc(note.id);

      batch.update(noteRef, {
        'position': i
      }); // Assuming "position" is the field that tracks order
    }

    try {
      await batch.commit(); // Perform all updates in a batch
    } catch (e) {
      print('Error updating note order in Firestore: $e');
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
}
