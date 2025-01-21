import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:writing_app/models/project_cubit.dart';
import 'package:writing_app/screens/notes/bloc/note_cubit.dart';
import 'package:writing_app/screens/notes/bloc/note_state.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/widgets/dynamic_image.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class NoteDetailsScreen extends StatefulWidget {
  final String noteId; // Pass only the ID, not the full Note object

  const NoteDetailsScreen({super.key, required this.noteId});

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  late Note currentNote;

  @override
  void initState() {
    super.initState();
    // Fetch the note using the Bloc
    final noteCubit = context.read<NoteCubit>();
    final projectCubit = context.read<ProjectCubit>();
    final project = projectCubit.selectedProject;
    noteCubit.fetchNotes(project!.id);
    final note = noteCubit.getNoteById(widget.noteId); // Fetch the note by ID
    if (note != null) {
      currentNote = note;
    }
  }

  @override
  Widget build(BuildContext context) {
    final projectCubit = context.read<ProjectCubit>();
    final project = projectCubit.selectedProject;
    // Ensure the Cubit fetches notes when the screen is built
    context.read<NoteCubit>().fetchNotes(project!.id);

    return SidebarLayout(
      activeRoute: "/notes",
      child: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          if (state is NoteLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NoteLoaded) {
            // Fetch the note by ID from the loaded notes
            try {
              print("trying to build note details for ${currentNote}");
              return _buildNoteDetails(context, currentNote);
            } catch (e) {
              return const Center(
                child: Text('Note not found'),
              );
            }
          } else if (state is NoteError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          }

          // Default fallback
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildNoteDetails(BuildContext context, Note note) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Note Image
            if (note.imageUrl != null)
              DynamicImageWidget(
                imagePath: note.imageUrl!,
                width: 140,
                height: 140,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
            const SizedBox(height: 20),

            // Note Details
            note.getNoteDetails().buildDetailsScreen(context),
          ],
        ),
      ),
    );
  }
}
