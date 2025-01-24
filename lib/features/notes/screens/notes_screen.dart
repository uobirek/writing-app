import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:writing_app/features/notes/cubit/note_cubit.dart';
import 'package:writing_app/features/notes/cubit/note_state.dart';
import 'package:writing_app/features/projects/cubit/project_cubit.dart';

import '../../../widgets/sidebar_layout.dart';
import '../widgets/category_tabs.dart';
import '../widgets/notes_list.dart';

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
    final project = projectCubit.selectedProject;
    final noteCubit = context.read<NoteCubit>();

    return SafeArea(
      child: SidebarLayout(
        activeRoute: '/notes',
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;

            return Padding(
              padding: isMobile
                  ? const EdgeInsets.symmetric(horizontal: 16, vertical: 20)
                  : const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: isMobile
                  ? Column(
                      children: [
                        BlocBuilder<NoteCubit, NoteState>(
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: DropdownButton<String>(
                                value: currentCategory,
                                onChanged: (category) {
                                  if (category != null) {
                                    noteCubit.filterNotes(
                                      category,
                                      project!.id,
                                    );
                                    updateCategory(category);
                                  }
                                },
                                items: [
                                  'Show All',
                                  'Worldbuilding',
                                  'Characters',
                                  'Outline',
                                ]
                                    .map(
                                      (category) => DropdownMenuItem(
                                        value: category,
                                        child: Text(
                                          category,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          },
                        ),
                        const Expanded(child: NotesList()),
                      ],
                    )
                  : DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
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
                                  noteCubit.filterNotes(category, project!.id);
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
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is NoteLoaded) {
                                    return const NotesList();
                                  } else if (state is NoteError) {
                                    return Center(child: Text(state.message));
                                  }
                                  return const Center(
                                    child: Text('No notes available.'),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
