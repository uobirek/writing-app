import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/features/authentication/login_screen.dart';
import 'package:writing_app/features/authentication/register_screen.dart';
import 'package:writing_app/features/authentication/welcome_screen.dart';
import 'package:writing_app/features/home/home_screen.dart';
import 'package:writing_app/features/notes/cubit/note_cubit.dart';
import 'package:writing_app/features/notes/screens/add_new_note.dart';
import 'package:writing_app/features/notes/screens/note_details_screen.dart';
import 'package:writing_app/features/notes/screens/note_editing_screen.dart';
import 'package:writing_app/features/notes/screens/notes_screen.dart';
import 'package:writing_app/features/projects/screens/add_project_screen.dart';
import 'package:writing_app/features/projects/screens/project_list_screen.dart';
import 'package:writing_app/features/research/research_screen.dart';
import 'package:writing_app/features/writing/cubit/chapter_cubit.dart';
import 'package:writing_app/features/writing/screens/chapter_editing_screen.dart';
import 'package:writing_app/features/writing/screens/chapters_screen.dart';
import 'package:writing_app/widgets/settings_dialog.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: '/welcome',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        pageBuilder: (context, state) => _noAnimationPage(const HomeScreen()),
      ),
      GoRoute(
        path: '/notes',
        builder: (context, state) => const NotesScreen(),
        pageBuilder: (context, state) => _noAnimationPage(const NotesScreen()),
      ),
      GoRoute(
        path: '/writing',
        builder: (context, state) => const ChaptersScreen(),
        pageBuilder: (context, state) =>
            _noAnimationPage(const ChaptersScreen()),
      ),
      GoRoute(
        path: '/research',
        builder: (context, state) => const ResearchScreen(),
        pageBuilder: (context, state) =>
            _noAnimationPage(const ResearchScreen()),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsDialog(),
        pageBuilder: (context, state) =>
            _noAnimationPage(const SettingsDialog()),
      ),
      GoRoute(
        path: '/note/:id',
        builder: (context, state) {
          final noteId = state.pathParameters['id']!;
          return BlocProvider.value(
            value: context.read<NoteCubit>(),
            child: NoteDetailsScreen(noteId: noteId),
          );
        },
      ),
      GoRoute(
        path: '/note/:id/editing',
        builder: (context, state) {
          final noteId = state.pathParameters['id']!;
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
          final chapterId = state.pathParameters['id']!;
          return BlocProvider.value(
            value: context.read<ChapterCubit>(),
            child: EditChapterScreen(
              chapterId: chapterId,
              isNewChapter: false,
            ),
          );
        },
      ),
      GoRoute(
        path: '/new-chapter',
        builder: (context, state) {
          return const EditChapterScreen(chapterId: '', isNewChapter: true);
        },
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) {
          return const WelcomeScreen();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) {
          return const LoginScreen();
        },
        pageBuilder: (context, state) {
          return _slideTransitionPage(
            child: const LoginScreen(),
            pageKey: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) {
          return const RegisterScreen();
        },
        pageBuilder: (context, state) {
          return _slideTransitionPage(
            child: const RegisterScreen(),
            pageKey: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: '/projects',
        builder: (context, state) {
          return const ProjectListScreen();
        },
      ),
      GoRoute(
        path: '/add_project',
        builder: (context, state) => AddProjectScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('No route defined for ${state.uri}'),
      ),
    ),
  );

  static GoRouter get router => _router;

  static CustomTransitionPage<void> _noAnimationPage(Widget child) {
    return CustomTransitionPage(
      transitionsBuilder: (_, __, ___, child) => child,
      transitionDuration: Duration.zero,
      child: child,
    );
  }

  static CustomTransitionPage<void> _slideTransitionPage({
    required Widget child,
    required LocalKey pageKey,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomTransitionPage<void>(
      key: pageKey,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1, 0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
