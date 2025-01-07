import 'package:flutter/material.dart';
import 'package:writing_app/data/notes_data.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/repositories/note_repository.dart';
import 'package:writing_app/screens/notes/widgets/draggable_note.dart';

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
  final NoteRepository _noteRepository = NoteRepository();
  List<Note> _notes = [];
  bool _isLoading = true;

  @override
  void didUpdateWidget(covariant NotesList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _filterNotes();
  }

  @override
  void initState() {
    super.initState();
    _fetchNotes();
    _filterNotes();
  }

  Future<void> _fetchNotes() async {
    setState(() => _isLoading = true);
    try {
      final notes = await _noteRepository.fetchAllNotes();
      setState(() {
        _notes = notes;
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() => _isLoading = false);
    }
  }

  void _filterNotes() {
    setState(() {
      filteredNotes = _notes.where((note) {
        return widget.currentCategory == 'Show All' ||
            note.category == widget.currentCategory;
      }).toList();
    });
  }

  void _deleteNote(String noteId) {
    setState(() {
      notes.removeWhere((note) => note.id == noteId); // Update global `notes`
      _filterNotes(); // Re-apply filter
    });
  }

  void _onNoteDropped(String draggedNoteId, String targetNoteId) {
    setState(() {
      // Find indices in global `notes` list
      final draggedNoteIndex =
          notes.indexWhere((note) => note.id == draggedNoteId);
      final targetNoteIndex =
          notes.indexWhere((note) => note.id == targetNoteId);

      if (draggedNoteIndex != -1 && targetNoteIndex != -1) {
        // Reorder in global `notes` list
        final draggedNote = notes.removeAt(draggedNoteIndex);
        notes.insert(targetNoteIndex, draggedNote);

        // Re-apply filter to reflect changes in `filteredNotes`
        _filterNotes();
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
            onDelete: () => _deleteNote(note.id), // Pass delete callback
          );
        }).toList(),
      ),
    );
  }
}
