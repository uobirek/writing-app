import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/widgets/note_card.dart';

class DraggableNote extends StatelessWidget {
  final Note note;
  final Function(String draggedNoteId, String targetNoteId) onNoteDropped;
  final VoidCallback onDelete; // New callback for delete

  const DraggableNote({
    super.key,
    required this.note,
    required this.onNoteDropped,
    required this.onDelete, // Accept delete callback
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onWillAcceptWithDetails: (draggedNoteId) {
        return draggedNoteId != note.id;
      },
      onAcceptWithDetails: (details) {
        onNoteDropped(details.data, note.id);
      },
      builder: (context, candidateData, rejectedData) {
        return Draggable<String>(
          data: note.id,
          feedback: Material(
            color: Colors.transparent,
            elevation: 10,
            borderRadius: BorderRadius.circular(10),
            child: NoteCard(
              note: note,
              onDelete: onDelete, // Pass delete callback to NoteCard
            ),
          ),
          childWhenDragging: Opacity(
            opacity: 0.5,
            child: NoteCard(
              note: note,
              onDelete: onDelete, // Pass delete callback to NoteCard
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: candidateData.isNotEmpty
                  ? Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.5),
                      width: 2,
                    )
                  : null,
              borderRadius: BorderRadius.circular(23),
            ),
            child: NoteCard(
              note: note,
              onDelete: onDelete, // Pass delete callback to NoteCard
            ),
          ),
        );
      },
    );
  }
}
