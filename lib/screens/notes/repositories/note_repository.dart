import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note.dart';
import '../models/character_note.dart';
import '../models/worldbuilding_note.dart';

class NoteRepository {
  final FirebaseFirestore _firestore;

  NoteRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

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

  /// Add a new note to Firestore
  Future<void> addNote(Note note) async {
    try {
      await _firestore.collection('notes').doc(note.id).set(note.toJson());
    } catch (e) {
      print('Error adding note: $e');
      rethrow;
    }
  }

  /// Update an existing note in Firestore
  Future<void> updateNote(Note note) async {
    try {
      await _firestore.collection('notes').doc(note.id).update(note.toJson());
    } catch (e) {
      print('Error updating note: $e');
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

  Future<void> deleteNoteById(String noteId) async {
    try {
      await _firestore.collection('notes').doc(noteId).delete();
    } catch (e) {
      print('Error deleting note: $e');
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
