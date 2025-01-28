import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:writing_app/features/home/project_info.dart';
import 'package:writing_app/features/projects/cubit/project_cubit.dart';
import 'package:writing_app/features/projects/cubit/project_states.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final projectCubit = context.read<ProjectCubit>();
    final userId = FirebaseAuth.instance.currentUser?.uid;

    // Fetch projects only if necessary
    if (userId != null && projectCubit.selectedProject == null) {
      projectCubit.fetchProjects(userId);
    }

    return SidebarLayout(
      activeRoute: '/',
      child: BlocBuilder<ProjectCubit, ProjectState>(
        builder: (context, state) {
          if (state is ProjectLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProjectLoaded || state is ProjectSelected) {
            final project = projectCubit.selectedProject;
            if (project != null) {
              return ProjectInfo(
                project: project,
              );
            } else {
              return const Center(child: Text('No project selected'));
            }
          } else if (state is ProjectError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          } else {
            return const Center(child: Text('No projects available'));
          }
        },
      ),
    );
  }
}
