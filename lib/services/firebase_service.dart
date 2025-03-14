import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:writing_app/features/notes/models/character_note.dart';
import 'package:writing_app/features/notes/models/note.dart';
import 'package:writing_app/features/notes/models/outline_note.dart'; // Import OutlineNote
import 'package:writing_app/features/notes/models/worldbuilding_note.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseDatabase _realtimeDb = FirebaseDatabase.instance;

  Future<void> saveNote(Note note, {bool useFirestore = true}) async {
    final json = note.toJson();

    if (useFirestore) {
      // Save to Firestore
      await _firestore.collection('notes').doc(note.id).set(json);
    } else {
      // Save to Realtime Database
      await _realtimeDb.ref('notes/${note.id}').set(json);
    }
  }

  Future<Note> getNote(String id, {bool useFirestore = true}) async {
    Map<String, dynamic> json;

    if (useFirestore) {
      final doc = await _firestore.collection('notes').doc(id).get();
      json = doc.data()!;
    } else {
      final snapshot = await _realtimeDb.ref('notes/$id').get();
      json = Map<String, dynamic>.from(snapshot.value! as Map);
    }

    // Handle note type
    switch (json['type']) {
      case 'CharacterNote':
        return CharacterNote.fromJson(json);
      case 'WorldbuildingNote':
        return WorldbuildingNote.fromJson(json);
      case 'OutlineNote': // Add support for OutlineNote
        return OutlineNote.fromJson(json);
      default:
        throw Exception("Unsupported note type: ${json['type']}");
    }
  }
}
