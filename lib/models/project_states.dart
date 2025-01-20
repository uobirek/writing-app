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
  final List<Project> projects;
  ProjectLoaded(this.projects);
}

class ProjectError extends ProjectState {
  final String message;
  ProjectError(this.message);
}

class ProjectSelected extends ProjectState {
  final String projectId;
  ProjectSelected(this.projectId);
}

class ProjectUpdating extends ProjectState {}
