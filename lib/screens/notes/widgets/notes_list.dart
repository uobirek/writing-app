import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/widgets/draggable_note.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/data/notes_data.dart';

class NotesList extends StatelessWidget {
  final String currentCategory;

  const NotesList({
    super.key,
    required this.currentCategory,
  });

  @override
  Widget build(BuildContext context) {
    final filteredNotes = notes.where((note) {
      return currentCategory == 'Show All' || note.category == currentCategory;
    }).toList();

    return SingleChildScrollView(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children:
            filteredNotes.map((note) => DraggableNote(note: note)).toList(),
      ),
    );
  }
}
