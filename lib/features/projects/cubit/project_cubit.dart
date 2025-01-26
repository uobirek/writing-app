import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:writing_app/features/projects/cubit/project_states.dart';
import 'package:writing_app/features/projects/models/project.dart';

import '../repositories/project_repository.dart';

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit(this.projectRepository) : super(ProjectInitial());
  final ProjectRepository projectRepository;
  List<Project> allProjects = [];
  Project? _selectedProject;

  Project? get selectedProject => _selectedProject;

  // Fetch all projects
  Future<void> fetchProjects(String userId) async {
    emit(ProjectLoading());
    try {
      allProjects = await projectRepository.fetchAllProjects(userId);
      emit(ProjectLoaded(allProjects));
    } catch (err) {
      emit(ProjectError('Failed to load projects: $err'));
    }
  }

  // Select a specific project and emit the selected state
  void selectProject(String projectId) {
    _selectedProject = allProjects.firstWhere(
      (project) => project.id == projectId,
    );

    if (_selectedProject != null) {
      emit(ProjectSelected(projectId));
    } else {
      emit(const ProjectError('Project not found'));
    }
  }

  // Fetch a project by its ID
  Future<void> fetchProjectById(String userId) async {
    if (_selectedProject != null) {
      try {
        emit(ProjectLoading());

        final project = await projectRepository.getProjectById(
          _selectedProject!.id,
          userId,
        );

        if (project != null) {
          _selectedProject = project;
          emit(ProjectSelected(project.id));
        } else {
          emit(const ProjectError('Project not found'));
        }
      } catch (err) {
        emit(ProjectError('Error fetching project: $err'));
      }
    }
  }

  // Add a new project
  Future<void> addProject(
    Project newProject,
    String userId,
    File? imageFile,
  ) async {
    emit(ProjectUpdating());
    try {
      final projectWithId =
          await projectRepository.addProject(newProject, userId, imageFile);
      allProjects.add(projectWithId);
      emit(ProjectLoaded(List.from(allProjects)));
    } catch (err) {
      emit(ProjectError('Failed to add project: $err'));
    }
  }

  // Update an existing project
  Future<void> updateProject(
    Project project,
    String userId,
    File? imageFile,
  ) async {
    emit(ProjectUpdating());
    try {
      await projectRepository.updateProject(project, userId, imageFile);
      final int index = allProjects.indexWhere((p) => p.id == project.id);
      if (index != -1) {
        allProjects[index] = project.copyWith(
          imageUrl: imageFile != null
              ? await projectRepository.uploadImageToCloudinary(imageFile)
              : project.imageUrl,
        );
      }
      emit(ProjectSelected(project.id));
    } catch (err) {
      emit(ProjectError('Failed to update project: $err'));
    }
  }

  // Delete a project
  Future<void> deleteProject(String projectId, String userId) async {
    try {
      await projectRepository.deleteProject(projectId, userId);
      allProjects.removeWhere((project) => project.id == projectId);

      if (_selectedProject?.id == projectId) {
        _selectedProject = null;
      }

      emit(ProjectLoaded(List.from(allProjects)));
    } catch (err) {
      emit(ProjectError('Failed to delete project: $err'));
    }
  }
}
