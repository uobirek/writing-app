import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/data/notes_data.dart';
import 'package:writing_app/screens/home/home_screen.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/note_details.dart';
import 'package:writing_app/screens/notes/notes_screen.dart';
import 'package:writing_app/screens/writing/writing_screen.dart';

class AppRouter {
  static GoRouter get router {
    return GoRouter(
      initialLocation: '/', // Set initial route
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomeScreen(),
          pageBuilder: (context, state) => _noAnimationPage(HomeScreen()),
        ),
        GoRoute(
          path: '/notes',
          builder: (context, state) => const NotesScreen(),
          pageBuilder: (context, state) =>
              _noAnimationPage(const NotesScreen()),
        ),
        GoRoute(
          path: '/writing',
          builder: (context, state) => const WritingScreen(),
          pageBuilder: (context, state) =>
              _noAnimationPage(const WritingScreen()),
        ),
        GoRoute(
          path: '/research',
          builder: (context, state) =>
              const WritingScreen(), // Assuming WritingScreen for research route as well
          pageBuilder: (context, state) =>
              _noAnimationPage(const WritingScreen()),
        ),
        GoRoute(
            path: '/note/:id',
            builder: (context, state) {
              final String noteId = state.params['id']!;
              Note note = notes.where((note) => note.id == noteId).first;
              return NoteDetailsScreen(note: note);
            })
      ],
      errorBuilder: (context, state) {
        return Scaffold(
          body: Center(child: Text('No route defined for ${state.location}')),
        );
      },
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
