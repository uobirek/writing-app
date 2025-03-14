import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:writing_app/features/writing/cubit/chapter_state.dart';
import 'package:writing_app/features/writing/models/chapter.dart';
import 'package:writing_app/features/writing/repositories/chapter_repository.dart';

class ChapterCubit extends Cubit<ChapterState> {
  ChapterCubit(this.chapterRepository) : super(ChapterInitial());
  final ChapterRepository chapterRepository;

  List<Chapter> allChapters = [];

  Future<void> fetchChapters(String projectId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    emit(ChapterLoading());
    try {
      allChapters = await chapterRepository.fetchAllChapters(userId, projectId);
      emit(ChapterLoaded(allChapters));
    } catch (err) {
      emit(ChapterError('Failed to load chapters: $err'));
    }
  }

  Future<void> addChapter(Chapter newChapter, String projectId) async {
    emit(ChapterUpdating());
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    if (projectId.isEmpty) {
      emit(ChapterError('No project found'));
      return;
    }

    try {
      final chapterWithId =
          await chapterRepository.addChapter(newChapter, userId, projectId);
      allChapters.add(chapterWithId);
      emit(ChapterLoaded(List.from(allChapters)));
    } catch (err) {
      emit(ChapterError('Failed to add chapter: $err'));
    }
  }

  Future<void> updateChapter(Chapter chapter, String projectId) async {
    emit(ChapterUpdating());
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    try {
      await chapterRepository.updateChapter(chapter, userId, projectId);
      final int index = allChapters.indexWhere((c) => c.id == chapter.id);
      if (index != -1) {
        allChapters[index] = chapter;
      }
      emit(ChapterLoaded(List.from(allChapters)));
    } catch (err) {
      emit(ChapterError('Failed to update chapter: $err'));
    }
  }

  Future<void> deleteChapter(String chapterId, String projectId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    try {
      await chapterRepository.deleteChapter(chapterId, userId, projectId);
      allChapters.removeWhere((chapter) => chapter.id == chapterId);
      emit(ChapterLoaded(List.from(allChapters)));
    } catch (err) {
      emit(ChapterError('Failed to delete chapter: $err'));
    }
  }
}
