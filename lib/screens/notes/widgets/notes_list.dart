import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:writing_app/screens/notes/bloc/note_cubit.dart';
import 'package:writing_app/screens/notes/bloc/note_state.dart';
import 'package:writing_app/screens/notes/widgets/draggable_note.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteCubit, NoteState>(
      builder: (context, state) {
        if (state is NoteLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NoteError) {
          return Center(child: Text(state.message));
        } else if (state is NoteLoaded) {
          final notes = state.notes;

          return SingleChildScrollView(
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: notes.map((note) {
                return DraggableNote(
                  note: note,
                  onNoteDropped: (draggedNoteId, targetNoteId) {
                    print("reordering");
                    print(draggedNoteId);
                    print(targetNoteId);
                    context
                        .read<NoteCubit>()
                        .reorderNotes(draggedNoteId, targetNoteId);
                  },
                  onDelete: () {
                    // Handle delete action here
                    context.read<NoteCubit>().deleteNote(note.id, "1");
                  },
                );
              }).toList(),
            ),
          );
        } else {
          return const Center(child: Text('No notes available.'));
        }
      },
    );
  }
}
