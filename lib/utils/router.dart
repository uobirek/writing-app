import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/data/notes_data.dart';
import 'package:writing_app/screens/home/home_screen.dart';
import 'package:writing_app/screens/notes/add_new_note.dart';
import 'package:writing_app/screens/notes/note_editing_screen.dart';
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
            final noteId = state.params['id'];
            final note =
                notes.firstWhere((n) => n.id == noteId); // Fetch the note by ID
            return NoteDetailsScreen(note: note);
          },
        ),
        GoRoute(
          path: '/note/:id/editing',
          builder: (context, state) {
            final noteId = state.params['id'];
            final note =
                notes.firstWhere((n) => n.id == noteId); // Fetch the note by ID
            return EditNoteScreen(note: note);
          },
        ),
        GoRoute(
          path: '/add_note',
          builder: (context, state) => const AddNoteScreen(),
        ),
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
