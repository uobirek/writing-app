import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:writing_app/features/writing/chapter_card.dart';
import 'package:writing_app/features/writing/cubit/chapter_cubit.dart';
import 'package:writing_app/features/writing/cubit/chapter_state.dart';
import 'package:writing_app/l10n/app_localizations.dart';

class ChapterList extends StatelessWidget {
  const ChapterList({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return BlocBuilder<ChapterCubit, ChapterState>(
      builder: (context, state) {
        if (state is ChapterLoading) {
          return const Expanded(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is ChapterError) {
          return Expanded(
            child: Center(child: Text(state.message)),
          );
        } else if (state is ChapterLoaded) {
          final chapters = state.chapters;
          if (chapters.isEmpty) {
            return Expanded(
              child: Center(child: Text(localizations!.noChapterAvailable)),
            );
          }
          return Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: chapters.map((chapter) {
                  return ChapterCard(chapter: chapter);
                }).toList(),
              ),
            ),
          );
        } else {
          return Expanded(
            child: Center(child: Text(localizations!.noChapterAvailable)),
          );
        }
      },
    );
  }
}
