import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:writing_app/screens/notes/bloc/note_state.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/repositories/note_repository.dart';

class NoteCubit extends Cubit<NoteState> {
  final NoteRepository noteRepository;
  List<Note> allNotes = []; // Cached notes list

  NoteCubit(this.noteRepository) : super(NoteInitial());

  /// Fetch all notes from the repository
  /// Fetch all notes from Firestore
  Future<void> fetchNotes() async {
    emit(NoteLoading());
    try {
      allNotes = await noteRepository.fetchAllNotes();
      emit(NoteLoaded(allNotes));
      print("we got new notes");
      print(allNotes); // Emit the loaded state with notes in the correct order
    } catch (e) {
      emit(NoteError("Failed to load notes: ${e.toString()}"));
    }
  }

  /// Filter notes by category
  Future<void> filterNotes(String category) async {
    emit(NoteLoading());
    try {
      if (category == 'Show All') {
        // Fetch all notes
        allNotes = await noteRepository.fetchAllNotes();
        emit(NoteLoaded(allNotes)); // Emit the loaded state with all notes
      } else {
        // Fetch notes by category
        final filteredNotes =
            await noteRepository.fetchNotesByCategory(category);
        emit(NoteLoaded(
            filteredNotes)); // Emit the loaded state with filtered notes
      }
    } catch (e) {
      emit(NoteError("Failed to filter notes: ${e.toString()}"));
    }
  }

  /// Add a new note
  Future<void> addNote(Note newNote) async {
    emit(NoteUpdating());
    try {
      await noteRepository.addNote(newNote);
      allNotes.add(newNote); // Update cached list
      allNotes = await noteRepository.fetchAllNotes();
      emit(NoteLoaded(List.from(allNotes))); // Emit updated list
    } catch (e) {
      emit(NoteError("Failed to add note: ${e.toString()}"));
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      // Call repository to delete the note from Firestore
      await noteRepository.deleteNoteById(noteId);

      // Remove the note from local list
      allNotes.removeWhere((note) => note.id == noteId);

      // Emit updated state after deletion
      emit(NoteLoaded(allNotes));
    } catch (e) {
      emit(NoteError("Failed to delete note: ${e.toString()}"));
    }
  }

  /// Update an existing note
  Future<void> updateNote(Note updatedNote) async {
    emit(NoteUpdating());
    try {
      await noteRepository.updateNote(updatedNote);
      final index = allNotes.indexWhere((note) => note.id == updatedNote.id);
      if (index != -1) {
        allNotes[index] = updatedNote; // Update cached list
        emit(NoteLoaded(List.from(allNotes))); // Emit updated list
      }
    } catch (e) {
      emit(NoteError("Failed to update note: ${e.toString()}"));
    }
  }

  Future<void> reorderNotes(String draggedNoteId, String targetNoteId) async {
    try {
      if (state is NoteLoaded) {
        // Safely cast the state to NoteLoaded to access the notes list
        final currentNotes = List<Note>.from((state as NoteLoaded).notes);

        // Find the indices of the dragged and target notes
        final draggedNoteIndex =
            currentNotes.indexWhere((note) => note.id == draggedNoteId);
        final targetNoteIndex =
            currentNotes.indexWhere((note) => note.id == targetNoteId);

        if (draggedNoteIndex == -1 || targetNoteIndex == -1) return;

        // Move the dragged note to the new position in the list
        final draggedNote = currentNotes[draggedNoteIndex];
        currentNotes.removeAt(draggedNoteIndex);
        currentNotes.insert(targetNoteIndex, draggedNote);

        // Update the positions of the notes in Firestore
        await noteRepository.updateNoteOrder(currentNotes);

        // Emit the updated list of notes
        emit(NoteLoaded(
            currentNotes)); // Emit the updated state with reordered notes
      }
    } catch (e) {
      print('Error reordering notes: $e');
      emit(NoteError('Failed to reorder notes: $e'));
    }
  }

  /// Get a note by ID (synchronous from cached data)
  Note? getNoteById(String id) {
    try {
      print("id is$id");
      return allNotes.firstWhere((note) => note.id == id);
    } catch (_) {
      print("no note");

      return null;
    }
  }
}
