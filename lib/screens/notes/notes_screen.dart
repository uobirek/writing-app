import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:writing_app/models/project_cubit.dart';
import 'package:writing_app/screens/notes/bloc/note_cubit.dart';
import 'package:writing_app/screens/notes/bloc/note_state.dart';
import 'package:writing_app/screens/notes/repositories/note_repository.dart';
import 'widgets/category_tabs.dart';
import 'widgets/notes_list.dart';
import '../../widgets/sidebar_layout.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  String currentCategory = 'Show All';

  void updateCategory(String category) {
    setState(() {
      currentCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final projectCubit = context.read<ProjectCubit>();
    final projectId = projectCubit.allProjects.isNotEmpty
        ? projectCubit.allProjects.first.id
        : '';
    return Scaffold(
      body: BlocProvider(
        create: (context) => NoteCubit(NoteRepository())..fetchNotes(projectId),
        child: SidebarLayout(
          activeRoute: '/notes',
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 30,
                    spreadRadius: 6,
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  BlocBuilder<NoteCubit, NoteState>(
                    builder: (context, state) {
                      return CategoryTabs(
                        currentCategory: currentCategory,
                        onCategorySelected: (category) {
                          context
                              .read<NoteCubit>()
                              .filterNotes(category, projectId);
                          updateCategory(category);
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: BlocBuilder<NoteCubit, NoteState>(
                        builder: (context, state) {
                          if (state is NoteLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is NoteLoaded) {
                            return const NotesList();
                          } else if (state is NoteError) {
                            return Center(child: Text(state.message));
                          }
                          return const Center(
                              child: Text('No notes available.'));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
