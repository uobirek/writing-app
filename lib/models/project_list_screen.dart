import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/models/parallax_flow_delegate.dart';
import 'package:writing_app/models/project.dart';
import 'package:writing_app/models/project_cubit.dart';
import 'package:writing_app/models/project_list_item.dart';
import 'package:writing_app/models/project_states.dart';
import 'package:writing_app/screens/notes/bloc/note_cubit.dart';
import 'package:writing_app/screens/notes/widgets/dynamic_image.dart';
import 'package:writing_app/screens/writing/chapter_cubit.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  _ProjectListScreenState createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null && userId.isNotEmpty) {
      context.read<ProjectCubit>().fetchProjects(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<ProjectCubit, ProjectState>(
        builder: (context, state) {
          if (state is ProjectLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProjectLoaded) {
            final projects = state.projects;
            return Padding(
              padding: const EdgeInsets.all(50),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Choose a project",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Which one are we working on today?",
                        style: Theme.of(context).textTheme.labelMedium),
                    const SizedBox(height: 20), // Spacing
                    Expanded(
                      // Makes only the project list scrollable
                      child: SizedBox(
                        width: 600,
                        child: ListView.builder(
                          itemCount: projects.length,
                          itemBuilder: (context, index) {
                            final project = projects[index];
                            return GestureDetector(
                              onTap: () {
                                _selectProject(context, project);
                              }, // Pass the project id
                              child: ProjectListItem(
                                imageUrl: project.imageUrl ?? '',
                                title: project.title,
                                description: project.description,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Text(
                "Failed to load projects",
                style: theme.textTheme.bodyMedium,
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open a dialog to create a new project
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _selectProject(BuildContext context, Project project) {
    context.read<ProjectCubit>().selectProject(project.id);
    context.read<NoteCubit>().fetchNotes(project.id);
    context.read<ChapterCubit>().fetchChapters(project.id);
    context.go('/');
  }
}
