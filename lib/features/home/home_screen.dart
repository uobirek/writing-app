import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:writing_app/features/projects/cubit/project_cubit.dart';
import 'package:writing_app/features/projects/cubit/project_states.dart';
import 'package:writing_app/features/projects/models/project.dart';
import 'package:writing_app/utils/gradient_text.dart';
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
              return const Center(child: Text('No projects available'));
            }
          },
        ),
      ),
    );
  }
}

class ProjectInfo extends StatefulWidget {
  const ProjectInfo({
    super.key,
    required this.project,
  });

  final Project project;

  @override
  ProjectInfoState createState() => ProjectInfoState();
}

class ProjectInfoState extends State<ProjectInfo> {
  bool _isDescriptionExpanded = false; // Track the description state

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header image
          Container(
            width: double.infinity,
            height: 250, // Fixed size for header image
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/dottie.jpg',
                ), // Replace with your image asset
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Title and Edit Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GradientText(
                  widget.project.title,
                  style: Theme.of(context).textTheme.titleLarge,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.onSecondary,
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    // Add functionality to edit the project
                  },
                ),
              ],
            ),
          ),

          // Description Section with Expand/Collapse Feature
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isDescriptionExpanded = !_isDescriptionExpanded;
                });
              },
              child: Text(
                _isDescriptionExpanded
                    ? widget.project.description
                    : widget.project.description.length > 100
                        ? '${widget.project.description.substring(0, 100)}...' // Preview text
                        : widget.project.description,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),

          // Add some spacing at the bottom of the screen
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
