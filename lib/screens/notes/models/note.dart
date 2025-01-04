import 'package:writing_app/screens/notes/editing/note_editing.dart';
import 'package:writing_app/screens/notes/note_details/note_details.dart';

abstract class Note {
  final String id;
  final String title;
  final DateTime createdAt;
  String? image;
  final String category;

  Note(
      {required this.id,
      required this.title,
      required this.createdAt,
      this.image,
      required this.category});

  // Abstract method to convert a Note to a JSON map
  Map<String, dynamic> toJson();

  // Abstract method to create a Note from a JSON map
  static Note fromJson(Map<String, dynamic> json) {
    throw UnimplementedError("Use specific subclass factory methods");
  }

  NoteDetails getNoteDetails();

  NoteEditing getNoteEditing();
}
