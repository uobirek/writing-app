import 'package:writing_app/features/notes/models/note.dart';
import 'package:writing_app/features/notes/screens/details/note_details.dart';
import 'package:writing_app/features/notes/screens/details/simple_note_details.dart';
import 'package:writing_app/features/notes/screens/editing/note_editing.dart';
import 'package:writing_app/features/notes/screens/editing/simple_note_editing.dart';

class SimpleNote extends Note {
  SimpleNote(
    this.specialData, {
    required super.id,
    required super.title,
    required super.createdAt,
    required super.imageUrl,
  }) : super(category: 'SimpleNote', position: 13);
  final String specialData;

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
