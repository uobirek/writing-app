import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/models/project_cubit.dart';
import 'package:writing_app/screens/notes/bloc/note_cubit.dart';
import 'package:writing_app/screens/notes/bloc/note_state.dart';
import 'package:writing_app/screens/notes/widgets/draggable_note.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: isMobile
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.primary,
          body: BlocBuilder<NoteCubit, NoteState>(
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
                          final projectCubit = context.read<ProjectCubit>();
                          final project = projectCubit.selectedProject;
                          context.read<NoteCubit>().reorderNotes(
                                draggedNoteId,
                                targetNoteId,
                                project!.id,
                              );
                        },
                        onDelete: () {
                          final projectCubit = context.read<ProjectCubit>();
                          final project = projectCubit.selectedProject;
                          context
                              .read<NoteCubit>()
                              .deleteNote(note.id, project!.id);
                        },
                      );
                    }).toList(),
                  ),
                );
              } else {
                return const Center(child: Text('No notes available.'));
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.go('/add_note');
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
