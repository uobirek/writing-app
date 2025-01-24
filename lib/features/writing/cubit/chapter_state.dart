import 'package:equatable/equatable.dart';
import 'package:writing_app/features/writing/models/chapter.dart';

abstract class ChapterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChapterInitial extends ChapterState {}

class ChapterLoading extends ChapterState {}

class ChapterLoaded extends ChapterState {
  ChapterLoaded(this.chapters);
  final List<Chapter> chapters;

  @override
  List<Object?> get props => [chapters];
}

class ChapterUpdating extends ChapterState {}

class ChapterError extends ChapterState {
  ChapterError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
