import 'package:equatable/equatable.dart';
import 'package:writing_app/models/project.dart';

abstract class ProjectState extends Equatable {
  const ProjectState();

  @override
  List<Object?> get props => [];
}

class ProjectInitial extends ProjectState {}

class ProjectLoading extends ProjectState {}

class ProjectLoaded extends ProjectState {
  ProjectLoaded(this.projects);
  final List<Project> projects;
}

class ProjectError extends ProjectState {
  ProjectError(this.message);
  final String message;
}

class ProjectSelected extends ProjectState {
  ProjectSelected(this.projectId);
  final String projectId;
}

class ProjectUpdating extends ProjectState {}
