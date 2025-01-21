import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/models/project_cubit.dart';
import 'package:writing_app/screens/writing/chapter_card.dart';
import 'package:writing_app/screens/writing/chapter_cubit.dart';
import 'package:writing_app/screens/writing/chapter_repository.dart';
import 'package:writing_app/screens/writing/chapter_state.dart';
import 'package:writing_app/screens/writing/models/chapter.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class WritingScreen extends StatelessWidget {
  const WritingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final projectCubit = context.read<ProjectCubit>();
    final project = projectCubit.selectedProject;

    return BlocProvider(
      create: (context) =>
          ChapterCubit(ChapterRepository())..fetchChapters(project!.id),
      child: SidebarLayout(
        activeRoute: '/writing',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 30,
                  spreadRadius: 6,
                  offset: const Offset(0, 10),
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Theme.of(context).colorScheme.secondaryContainer,
                  Colors.white,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Chapters",
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 30),
                      const ChapterList(),
                    ],
                  ),
                  Positioned(
                    bottom: 15,
                    right: 15,
                    child: FloatingActionButton(
                      onPressed: () {
                        context.go('/new-chapter');
                      },
                      child: const Icon(Icons.add),
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

class ChapterList extends StatelessWidget {
  const ChapterList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChapterCubit, ChapterState>(
      builder: (context, state) {
        if (state is ChapterLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ChapterError) {
          return Center(child: Text(state.message));
        } else if (state is ChapterLoaded) {
          final chapters = state.chapters;

          return SingleChildScrollView(
            child: Column(
              spacing: 10,
              children: chapters.map((chapter) {
                return ChapterCard(chapter: chapter);
              }).toList(),
            ),
          );
        } else {
          return const Center(child: Text('No chapter available.'));
        }
      },
    );
  }
}
