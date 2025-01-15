import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:writing_app/screens/writing/chapter_state.dart';
import 'package:writing_app/screens/writing/models/chapter.dart';
import 'chapter_repository.dart';

class ChapterCubit extends Cubit<ChapterState> {
  final ChapterRepository chapterRepository;

  ChapterCubit(this.chapterRepository) : super(ChapterInitial());

  List<Chapter> allChapters = [];

  Future<void> fetchChapters() async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    emit(ChapterLoading());
    try {
      allChapters = await chapterRepository.fetchAllChapters(userId);
      emit(ChapterLoaded(allChapters));
    } catch (e) {
      emit(ChapterError('Failed to load chapters: $e'));
    }
  }

  Future<void> addChapter(Chapter newChapter) async {
    emit(ChapterUpdating());
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    try {
      final chapterWithId =
          await chapterRepository.addChapter(newChapter, userId);
      allChapters.add(chapterWithId);
      emit(ChapterLoaded(List.from(allChapters)));
    } catch (e) {
      emit(ChapterError('Failed to add chapter: $e'));
    }
  }

  Future<void> updateChapter(Chapter chapter) async {
    emit(ChapterUpdating());
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    try {
      await chapterRepository.updateChapter(chapter, userId);
      int index = allChapters.indexWhere((c) => c.id == chapter.id);
      if (index != -1) {
        allChapters[index] = chapter;
      }
      emit(ChapterLoaded(List.from(allChapters)));
    } catch (e) {
      emit(ChapterError('Failed to update chapter: $e'));
    }
  }

  Future<void> deleteChapter(String chapterId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    try {
      await chapterRepository.deleteChapter(chapterId, userId);
      allChapters.removeWhere((chapter) => chapter.id == chapterId);
      emit(ChapterLoaded(List.from(allChapters)));
    } catch (e) {
      emit(ChapterError('Failed to delete chapter: $e'));
    }
  }
}
