import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/authentication/login_screen.dart';
import 'package:writing_app/firebase_options.dart';
import 'package:writing_app/models/project.dart';
import 'package:writing_app/models/project_cubit.dart';
import 'package:writing_app/models/project_list_screen.dart';
import 'package:writing_app/models/project_repository.dart';
import 'package:writing_app/screens/notes/bloc/note_cubit.dart';
import 'package:writing_app/screens/notes/repositories/note_repository.dart';
import 'package:writing_app/screens/writing/chapter_cubit.dart';
import 'package:writing_app/screens/writing/chapter_repository.dart';
import 'package:writing_app/utils/router.dart';
import 'package:writing_app/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteCubit>(
          create: (context) => NoteCubit(NoteRepository()),
        ),
        BlocProvider<ChapterCubit>(
          create: (context) => ChapterCubit(ChapterRepository()),
        ),
        BlocProvider<ProjectCubit>(
          create: (context) {
            print(
                'Initializing ProjectCubit'); // Debug print to confirm initialization
            return ProjectCubit(ProjectRepository());
          },
        ),
      ],
      child: MaterialApp.router(
        themeMode: ThemeMode.light,
        theme: GlobalThemeData.lightThemeData,
        darkTheme: GlobalThemeData.darkThemeData,
        title: 'Writing App',
        routerConfig: AppRouter.router, // GoRouter is fully initialized here
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          // User is signed in, trigger fetchProjects
          final userId = snapshot.data?.uid ?? '';
          if (userId.isNotEmpty) {
            context.read<ProjectCubit>().fetchProjects(userId);
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/projects'); // Go to home route
          });
        } else {
          // User is not signed in
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/login'); // Go to login route
          });
        }
        return const SizedBox.shrink(); // Placeholder while navigating
      },
    );
  }
}
