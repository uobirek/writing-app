import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:writing_app/features/notes/cubit/note_state.dart';
import 'package:writing_app/features/notes/models/note.dart';
import 'package:writing_app/features/notes/repositories/note_repository.dart';

class NoteCubit extends Cubit<NoteState> {
  // Cached notes list

  NoteCubit(this.noteRepository) : super(NoteInitial());
  final NoteRepository noteRepository;
  List<Note> allNotes = [];

  /// Fetch all notes from Firestore
  Future<void> fetchNotes(String projectId) async {
    emit(NoteLoading());
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      allNotes = await noteRepository.fetchAllNotes(userId, projectId);
      emit(NoteLoaded(allNotes));
    } catch (err) {
      emit(NoteError('Failed to load notes: $err'));
    }
  }

  /// Filter notes by category
  Future<void> filterNotes(String category, String projectId) async {
    emit(NoteLoading());
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    try {
      if (category == 'Show All') {
        allNotes = await noteRepository.fetchAllNotes(userId, projectId);
        emit(NoteLoaded(allNotes));
      } else {
        final filteredNotes = await noteRepository.fetchNotesByCategory(
          userId,
          category,
          projectId,
        );
        emit(NoteLoaded(filteredNotes));
      }
    } catch (err) {
      emit(NoteError('Failed to filter notes: $err'));
    }
  }

  Future<void> addNote(Note newNote, File? imageFile, String projectId) async {
    emit(NoteUpdating());
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    try {
      await noteRepository.addNote(newNote, imageFile, userId, projectId);
      allNotes.add(newNote);
      allNotes = await noteRepository.fetchAllNotes(userId, projectId);
      emit(NoteLoaded(List.from(allNotes))); // Emit updated list
    } catch (err) {
      emit(NoteError('Failed to add note: $err'));
    }
  }

  Future<void> deleteNote(String noteId, String projectId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    try {
      await noteRepository.deleteNoteById(noteId, userId, projectId);
      allNotes.removeWhere((note) => note.id == noteId);
      emit(NoteLoaded(allNotes));
    } catch (err) {
      emit(NoteError('Failed to delete note: $err'));
    }
  }

  Future<void> updateNote(
    Note updatedNote,
    File? imageFile,
    String projectId,
  ) async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    emit(NoteUpdating());
    try {
      await noteRepository.updateNote(
        updatedNote,
        imageFile,
        userId,
        projectId,
      );
      final index = allNotes.indexWhere((note) => note.id == updatedNote.id);
      if (index != -1) {
        allNotes[index] = updatedNote;
        emit(NoteLoaded(List.from(allNotes))); // Emit updated list
      }
    } catch (err) {
      emit(NoteError('Failed to update note: $err'));
    }
  }

  Future<void> reorderNotes(
    String draggedNoteId,
    String targetNoteId,
    String projectId,
  ) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      if (state is NoteLoaded) {
        // Safely cast the state to NoteLoaded to access the notes list
        final currentNotes = List<Note>.from((state as NoteLoaded).notes);

        // Find the indices of the dragged and target notes
        final draggedNoteIndex =
            currentNotes.indexWhere((note) => note.id == draggedNoteId);
        final targetNoteIndex =
            currentNotes.indexWhere((note) => note.id == targetNoteId);

        if (draggedNoteIndex == -1 || targetNoteIndex == -1) {
          return;
        }

        // Move the dragged note to the new position in the list
        final draggedNote = currentNotes[draggedNoteIndex];
        currentNotes
          ..removeAt(draggedNoteIndex)
          ..insert(targetNoteIndex, draggedNote);

        // Update the positions of the notes in Firestore
        await noteRepository.updateNoteOrder(currentNotes, userId, projectId);

        // Emit the updated list of notes
        emit(
          NoteLoaded(
            currentNotes,
          ),
        ); // Emit the updated state with reordered notes
      }
    } catch (err) {
      emit(NoteError('Failed to reorder notes: $err'));
    }
  }

  /// Get a note by ID (synchronous from cached data)
  Note? getNoteById(String id) {
    try {
      return allNotes.firstWhere((note) => note.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<Note?> fetchNoteById(
    String noteId,
    String userId,
    String projectId,
  ) async {
    try {
      emit(NoteLoading());
      final note = await noteRepository.getNoteById(
        noteId,
        userId,
        projectId,
      ); // Fetch from repository
      if (!(note == null)) {
        emit(NoteLoaded([note])); // Update state
      }
      return note;
    } catch (err) {
      emit(NoteError('Failed to fetch note: $err'));
      return null;
    }
  }
}
