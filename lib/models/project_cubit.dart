import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:writing_app/models/project.dart';
import 'package:writing_app/models/project_states.dart';

import 'project_repository.dart';

class ProjectCubit extends Cubit<ProjectState> {
  final ProjectRepository projectRepository;

  ProjectCubit(this.projectRepository) : super(ProjectInitial());

  List<Project> allProjects = [];
  Future<void> fetchProjects(String userId) async {
    emit(ProjectLoading());
    try {
      print('Fetching projects for userId: $userId'); // Debug print
      allProjects = await projectRepository.fetchAllProjects(userId);
      print(allProjects);
      emit(ProjectLoaded(allProjects));
    } catch (e) {
      print("ERROR");
      print('Error fetching projects: $e'); // Debug error message
      emit(ProjectError('Failed to load projects: $e'));
    }
  }

  Future<void> addProject(Project newProject, String userId) async {
    emit(ProjectUpdating());
    try {
      final projectWithId =
          await projectRepository.addProject(newProject, userId);
      allProjects.add(projectWithId);
      emit(ProjectLoaded(List.from(allProjects)));
    } catch (e) {
      emit(ProjectError('Failed to add project: $e'));
    }
  }

  Future<void> updateProject(Project project, String userId) async {
    emit(ProjectUpdating());
    try {
      await projectRepository.updateProject(project, userId);
      int index = allProjects.indexWhere((p) => p.id == project.id);
      if (index != -1) {
        allProjects[index] = project;
      }
      emit(ProjectLoaded(List.from(allProjects)));
    } catch (e) {
      emit(ProjectError('Failed to update project: $e'));
    }
  }

  Future<void> deleteProject(String projectId, String userId) async {
    try {
      await projectRepository.deleteProject(projectId, userId);
      allProjects.removeWhere((project) => project.id == projectId);
      emit(ProjectLoaded(List.from(allProjects)));
    } catch (e) {
      emit(ProjectError('Failed to delete project: $e'));
    }
  }
}
