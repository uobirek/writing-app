import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:writing_app/features/notes/models/note.dart';
import 'package:writing_app/features/notes/widgets/note_card.dart';

class DraggableNote extends StatelessWidget {
  const DraggableNote({
    super.key,
    required this.note,
    required this.onNoteDropped,
    required this.onDelete,
  });

  final Note note;
  final void Function(String draggedNoteId, String targetNoteId) onNoteDropped;
  final VoidCallback onDelete;

  bool _isMobile() {
    return defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android;
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onWillAcceptWithDetails: (draggedNoteId) {
        return draggedNoteId.data != note.id;
      },
      onAcceptWithDetails: (details) {
        onNoteDropped(details.data, note.id);
      },
      builder: (context, candidateData, rejectedData) {
        return _isMobile()
            ? LongPressDraggable<String>(
                data: note.id,
                feedback: Material(
                  color: Colors.transparent,
                  elevation: 10,
                  borderRadius: BorderRadius.circular(10),
                  child: NoteCard(
                    note: note,
                    onDelete: onDelete,
                  ),
                ),
                childWhenDragging: Opacity(
                  opacity: 0.5,
                  child: NoteCard(
                    note: note,
                    onDelete: onDelete,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: candidateData.isNotEmpty
                        ? Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withValues(alpha: 0.5),
                            width: 2,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(23),
                  ),
                  child: NoteCard(
                    note: note,
                    onDelete: onDelete,
                  ),
                ),
              )
            : Draggable<String>(
                data: note.id,
                feedback: Material(
                  color: Colors.transparent,
                  elevation: 10,
                  borderRadius: BorderRadius.circular(10),
                  child: NoteCard(
                    note: note,
                    onDelete: onDelete,
                  ),
                ),
                childWhenDragging: Opacity(
                  opacity: 0.5,
                  child: NoteCard(
                    note: note,
                    onDelete: onDelete,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: candidateData.isNotEmpty
                        ? Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withValues(alpha: 0.5),
                            width: 2,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(23),
                  ),
                  child: NoteCard(
                    note: note,
                    onDelete: onDelete,
                  ),
                ),
              );
      },
    );
  }
}
