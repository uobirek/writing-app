import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:writing_app/screens/writing/chapter_state.dart';
import 'package:writing_app/screens/writing/models/chapter.dart';
import 'chapter_repository.dart';

class ChapterCubit extends Cubit<ChapterState> {
  final ChapterRepository chapterRepository;

  ChapterCubit(this.chapterRepository) : super(ChapterInitial());

  List<Chapter> allChapters = [];

  Future<void> fetchChapters() async {
    emit(ChapterLoading());
    try {
      allChapters = await chapterRepository.fetchAllChapters();
      emit(ChapterLoaded(allChapters));
    } catch (e) {
      emit(ChapterError('Failed to load chapters: $e'));
    }
  }

  Future<void> addChapter(Chapter newChapter) async {
    emit(ChapterUpdating());
    try {
      await chapterRepository.addChapter(newChapter);
      allChapters.add(newChapter);
      emit(ChapterLoaded(List.from(allChapters)));
    } catch (e) {
      emit(ChapterError('Failed to add chapter: $e'));
    }
  }

  Future<void> updateChapter(Chapter chapter) async {
    emit(ChapterUpdating());
    try {
      await chapterRepository.updateChapter(chapter);
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
    try {
      await chapterRepository.deleteChapter(chapterId);
      allChapters.removeWhere((chapter) => chapter.id == chapterId);
      emit(ChapterLoaded(List.from(allChapters)));
    } catch (e) {
      emit(ChapterError('Failed to delete chapter: $e'));
    }
  }
}
