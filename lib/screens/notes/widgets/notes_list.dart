import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/widgets/draggable_note.dart';
import 'package:writing_app/data/notes_data.dart';

class NotesList extends StatefulWidget {
  final String currentCategory;

  const NotesList({
    super.key,
    required this.currentCategory,
  });

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  List<Note> filteredNotes = [];

  @override
  void didUpdateWidget(covariant NotesList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _filterNotes();
  }

  @override
  void initState() {
    super.initState();
    _filterNotes();
  }

  void _filterNotes() {
    setState(() {
      filteredNotes = notes.where((note) {
        return widget.currentCategory == 'Show All' ||
            note.category == widget.currentCategory;
      }).toList();
    });
  }

  void _onNoteDropped(String draggedNoteId, String targetNoteId) {
    setState(() {
      final draggedNoteIndex =
          filteredNotes.indexWhere((note) => note.id == draggedNoteId);
      final targetNoteIndex =
          filteredNotes.indexWhere((note) => note.id == targetNoteId);

      if (draggedNoteIndex != -1 && targetNoteIndex != -1) {
        final draggedNote = filteredNotes.removeAt(draggedNoteIndex);
        filteredNotes.insert(targetNoteIndex, draggedNote);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: filteredNotes.map((note) {
          return DraggableNote(
            note: note,
            onNoteDropped: _onNoteDropped,
          );
        }).toList(),
      ),
    );
  }
}
