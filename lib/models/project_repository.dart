import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:writing_app/models/project.dart';

class ProjectRepository {
  final FirebaseFirestore _firestore;

  ProjectRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;
  Future<List<Project>> fetchAllProjects(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .get();

      if (snapshot.docs.isEmpty) {
        print('No projects found for userId: $userId');
        return [];
      }

      List<Project> projects = [];
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Project.fromJson(data);
      }).toList();
      return projects;
    } catch (e) {
      print('Error fetching projects: $e');
      throw Exception('Failed to fetch projects: $e');
    }
  }

  Future<Project> addProject(Project project, String userId) async {
    try {
      final docRef = await _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .add(project.toJson());
      await docRef.update({'id': docRef.id});
      return project.copyWith(id: docRef.id);
    } catch (e) {
      throw Exception('Failed to add project: $e');
    }
  }

  Future<void> updateProject(Project project, String userId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .doc(project.id)
          .set(project.toJson());
    } catch (e) {
      throw Exception('Failed to update project: $e');
    }
  }

  Future<void> deleteProject(String projectId, String userId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('projects')
          .doc(projectId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete project: $e');
    }
  }
}
