import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note.dart';
import '../models/character_note.dart';
import '../models/worldbuilding_note.dart';

class NoteRepository {
  final FirebaseFirestore _firestore;

  NoteRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Fetch all notes
  Future<List<Note>> fetchAllNotes() async {
    try {
      final snapshot = await _firestore.collection('notes').get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        final type = data['type'];

        if (type == 'CharacterNote') {
          return CharacterNote.fromJson(data);
        } else if (type == 'WorldbuildingNote') {
          return WorldbuildingNote.fromJson(data);
        } else {
          throw Exception('Unknown note type');
        }
      }).toList();
    } catch (e) {
      print('Error fetching notes: $e');
      rethrow;
    }
  }

  // Fetch notes by category
  Future<List<Note>> fetchNotesByCategory(String category) async {
    try {
      final snapshot = await _firestore
          .collection('notes')
          .where('category', isEqualTo: category)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        final type = data['type'];

        if (type == 'CharacterNote') {
          return CharacterNote.fromJson(data);
        } else if (type == 'WorldbuildingNote') {
          return WorldbuildingNote.fromJson(data);
        } else {
          throw Exception('Unknown note type');
        }
      }).toList();
    } catch (e) {
      print('Error fetching notes by category: $e');
      rethrow;
    }
  }
}
