import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/note_details/note_details.dart';

class SimpleNoteDetails implements NoteDetails {
  @override
  Widget buildDetailsScreen(BuildContext context) {
    return const Text('Simple details');
  }
}
