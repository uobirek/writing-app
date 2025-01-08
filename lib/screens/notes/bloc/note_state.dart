import 'package:equatable/equatable.dart';
import '../models/note.dart';

abstract class NoteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  final List<Note> notes;

  NoteLoaded(this.notes);

  @override
  List<Object?> get props => [notes];
}

class NoteUpdating extends NoteState {}

class NoteError extends NoteState {
  final String message;

  NoteError(this.message);

  @override
  List<Object?> get props => [message];
}
