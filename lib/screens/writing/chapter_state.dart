import 'package:equatable/equatable.dart';
import 'package:writing_app/screens/writing/models/chapter.dart';

abstract class ChapterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChapterInitial extends ChapterState {}

class ChapterLoading extends ChapterState {}

class ChapterLoaded extends ChapterState {
  final List<Chapter> chapters;

  ChapterLoaded(this.chapters);

  @override
  List<Object?> get props => [chapters];
}

class ChapterUpdating extends ChapterState {}

class ChapterError extends ChapterState {
  final String message;

  ChapterError(this.message);

  @override
  List<Object?> get props => [message];
}
