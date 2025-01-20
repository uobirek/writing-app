import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:writing_app/gradient_text.dart';
import 'package:writing_app/models/project.dart';
import 'package:writing_app/models/project_cubit.dart';
import 'package:writing_app/models/project_states.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final projectCubit = context.read<ProjectCubit>();
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return SidebarLayout(
      activeRoute: '/',
      child: BlocListener<ProjectCubit, ProjectState>(
        listener: (context, state) {
          if (state is ProjectSelected && userId != null) {
            projectCubit.fetchProjectById(userId);
          }
        },
        child: BlocBuilder<ProjectCubit, ProjectState>(
          builder: (context, state) {
            if (state is ProjectLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProjectSelected || state is ProjectLoaded) {
              final project = projectCubit.selectedProject;
              if (project != null) {
                return ProjectInfo(project: project);
              } else {
                return const Center(child: Text('No project selected'));
              }
            } else if (state is ProjectError) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            } else {
              print(state);
              return const Center(child: Text('No projects available'));
            }
          },
        ),
      ),
    );
  }
}

class ProjectInfo extends StatelessWidget {
  const ProjectInfo({
    super.key,
    required this.project,
  });

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(
              project.title,
              style: Theme.of(context).textTheme.titleLarge,
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.onSecondary
              ]),
            ),
            const SizedBox(height: 20),
            Text(project.description,
                style: Theme.of(context).textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}
