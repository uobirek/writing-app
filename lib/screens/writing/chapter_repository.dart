import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:writing_app/screens/writing/models/chapter.dart';

class ChapterRepository {
  ChapterRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;
  final FirebaseFirestore _firestore;

  Future<List<Chapter>> fetchAllChapters(
    String userId,
    String projectId,
  ) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .doc(projectId)
          .collection('chapters')
          .orderBy('position') // Fetch chapters in order
          .get();
      return querySnapshot.docs
          .map((doc) => Chapter.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch chapters: $e');
    }
  }

  Future<Chapter> addChapter(
    Chapter chapter,
    String userId,
    String projectId,
  ) async {
    try {
      final docRef = await _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .doc(projectId)
          .collection('chapters')
          .add(chapter.toJson());
      await docRef.update({'id': docRef.id});

      return chapter.copyWith(id: docRef.id);
    } catch (e) {
      throw Exception('Failed to add chapter: $e');
    }
  }

  Future<void> deleteChapter(
    String chapterId,
    String userId,
    String projectId,
  ) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .doc(projectId)
          .collection('chapters')
          .doc(chapterId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete chapter: $e');
    }
  }

  Future<void> updateChapter(
    Chapter chapter,
    String userId,
    String projectId,
  ) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .doc(projectId)
          .collection('chapters')
          .doc(chapter.id)
          .set(chapter.toJson());
    } catch (e) {
      throw Exception('Failed to update chapter: $e');
    }
  }
}
