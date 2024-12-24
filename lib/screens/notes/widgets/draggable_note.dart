import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/widgets/note_card.dart';

class DraggableNote extends StatelessWidget {
  final Note note;

  const DraggableNote({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: note.id,
      feedback: Material(
        color: Colors.transparent,
        elevation: 10,
        borderRadius: BorderRadius.circular(10),
        child: NoteCard(note: note),
      ),
      childWhenDragging: const SizedBox.shrink(),
      child: DragTarget<String>(
        onAccept: (draggedNoteId) {
          // Handle drop logic
        },
        builder: (context, candidateData, rejectedData) {
          return Container(
            decoration: BoxDecoration(
              border: candidateData.isNotEmpty
                  ? Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.3),
                      width: 5)
                  : null,
              borderRadius: BorderRadius.circular(23),
            ),
            child: NoteCard(note: note),
          );
        },
      ),
    );
  }
}
