import 'package:writing_app/screens/notes/editing/note_editing.dart';
import 'package:writing_app/screens/notes/editing/simple_note_editing.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/note_details/note_details.dart';
import 'package:writing_app/screens/notes/note_details/simple_note_details.dart';

class SimpleNote extends Note {
  final String specialData;

  SimpleNote(
    this.specialData, {
    required super.id,
    required super.title,
    required super.createdAt,
    required super.imageUrl,
  }) : super(category: "SimpleNote", position: 13);

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  NoteDetails getNoteDetails() {
    return SimpleNoteDetails();
  }

  @override
  NoteEditing getNoteEditing() {
    return SimpleNoteEditing(this);
  }
}
