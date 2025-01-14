import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/authentication/login_screen.dart';
import 'package:writing_app/screens/notes/bloc/note_cubit.dart';
import 'package:writing_app/screens/home/home_screen.dart';
import 'package:writing_app/screens/notes/add_new_note.dart';
import 'package:writing_app/screens/notes/note_details_screen.dart';
import 'package:writing_app/screens/notes/note_editing_screen.dart';
import 'package:writing_app/screens/notes/notes_screen.dart';
import 'package:writing_app/screens/writing/chapter_cubit.dart';
import 'package:writing_app/screens/writing/chapter_editing_screen.dart';
import 'package:writing_app/screens/writing/writing_screen.dart';

class AppRouter {
  static GoRouter get router {
    return GoRouter(
      initialLocation: '/', // Set the initial route
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
          pageBuilder: (context, state) => _noAnimationPage(const HomeScreen()),
        ),
        GoRoute(
          path: '/notes',
          builder: (context, state) => const NotesScreen(),
          pageBuilder: (context, state) =>
              _noAnimationPage(const NotesScreen()),
        ),
        GoRoute(
          path: '/writing',
          builder: (context, state) => WritingScreen(),
          pageBuilder: (context, state) => _noAnimationPage(WritingScreen()),
        ),
        GoRoute(
          path: '/note/:id',
          builder: (context, state) {
            final noteId = state.params['id']!;

            // Wrap the screen with a BlocProvider or BlocBuilder to fetch the note
            return BlocProvider.value(
              value: context.read<NoteCubit>(), // Use the existing NoteCubit
              child: NoteDetailsScreen(noteId: noteId),
            );
          },
        ),
        GoRoute(
          path: '/note/:id/editing',
          builder: (context, state) {
            final noteId = state.params['id']!;

            return BlocProvider.value(
              value: context.read<NoteCubit>(),
              child: EditNoteScreen(noteId: noteId),
            );
          },
        ),
        GoRoute(
          path: '/add_note',
          builder: (context, state) => const AddNoteScreen(),
        ),
        GoRoute(
            path: '/chapter/:id',
            builder: (context, state) {
              final chapterId = state.params['id']!;
              return BlocProvider.value(
                  value: context.read<ChapterCubit>(),
                  child: EditChapterScreen(
                    chapterId: chapterId,
                    isNewChapter: false,
                  ));
            }),
        GoRoute(
            path: '/new-chapter',
            builder: (context, state) {
              return EditChapterScreen(chapterId: "", isNewChapter: true);
            }),
        GoRoute(
            path: '/login',
            builder: (context, state) {
              return LoginScreen();
            }),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Text('No route defined for ${state.location}'),
        ),
      ),
    );
  }

  // Custom page with no animation
  static CustomTransitionPage _noAnimationPage(Widget child) {
    return CustomTransitionPage(
      transitionsBuilder: (_, __, ___, child) =>
          child, // No transition, just show the child
      transitionDuration: Duration.zero, // Disable transition animation
      child: child,
    );
  }
}
