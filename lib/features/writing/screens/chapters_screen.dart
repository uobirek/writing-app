import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/features/projects/cubit/project_cubit.dart';
import 'package:writing_app/features/writing/chapter_card.dart';
import 'package:writing_app/features/writing/cubit/chapter_cubit.dart';
import 'package:writing_app/features/writing/cubit/chapter_state.dart';
import 'package:writing_app/features/writing/repositories/chapter_repository.dart';
import 'package:writing_app/features/writing/widgets/chapter_list.dart';
import 'package:writing_app/l10n/app_localizations.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class ChaptersScreen extends StatelessWidget {
  const ChaptersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final projectCubit = context.read<ProjectCubit>();
    final project = projectCubit.selectedProject;
    final localizations = AppLocalizations.of(context);

    return BlocProvider(
      create: (context) =>
          ChapterCubit(ChapterRepository())..fetchChapters(project!.id),
      child: SafeArea(
        // Wrap the entire content inside SafeArea
        child: SidebarLayout(
          activeRoute: '/writing',
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Determine if the device is mobile based on width using constraints
              final bool isMobile = constraints.maxWidth < 600;

              return Padding(
                padding: EdgeInsets.all(
                  isMobile ? 0 : 50.0,
                ), // Adjust padding based on screen size
                child: Container(
                  decoration: BoxDecoration(
                    // Remove shadow and border-radius on mobile
                    borderRadius: isMobile
                        ? BorderRadius.zero
                        : BorderRadius.circular(20),
                    boxShadow: isMobile
                        ? []
                        : [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
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
                        Theme.of(context).colorScheme.surface,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 20.0 : 40.0,
                      horizontal: isMobile ? 16.0 : 30.0,
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              localizations!.chapters,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 30),
                            const ChapterList(),
                          ],
                        ),
                        Positioned(
                          bottom: isMobile ? 8 : 15,
                          right: isMobile ? 8 : 15,
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
              );
            },
          ),
        ),
      ),
    );
  }
}
