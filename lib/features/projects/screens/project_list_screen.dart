import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/features/notes/cubit/note_cubit.dart';
import 'package:writing_app/features/projects/cubit/project_cubit.dart';
import 'package:writing_app/features/projects/cubit/project_states.dart';
import 'package:writing_app/features/projects/models/project.dart';
import 'package:writing_app/features/projects/widgets/project_list_item.dart';
import 'package:writing_app/features/writing/cubit/chapter_cubit.dart';
import 'package:writing_app/l10n/app_localizations.dart';

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
    final localizations = AppLocalizations.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<ProjectCubit, ProjectState>(
          builder: (context, state) {
            if (state is ProjectLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProjectLoaded) {
              final projects = state.projects;
              return Padding(
                padding: const EdgeInsets.all(30),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localizations!.chooseAProject,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        localizations.workingOnToday,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: SizedBox(
                          width: 600,
                          child: ListView.builder(
                            itemCount: projects.length,
                            itemBuilder: (context, index) {
                              final project = projects[index];
                              return GestureDetector(
                                onTap: () {
                                  _selectProject(context, project);
                                },
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
                  'No projects yet?\nTry to create one!',
                  style: theme.textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.go('/add_project');
          },
          child: const Icon(Icons.add),
        ),
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
