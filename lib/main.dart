import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/firebase_options.dart';
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
      ],
      child: MaterialApp.router(
        themeMode: ThemeMode.light,
        theme: GlobalThemeData.lightThemeData,
        darkTheme: GlobalThemeData.darkThemeData,
        title: 'Writing App',
        routerConfig: AppRouter.router, // Use GoRouter for navigation
      ),
    );
  }
}

// Modified AuthWrapper to work with GoRouter
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
          // Navigate to home screen if the user is logged in
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/'); // Go to home route
          });
        } else {
          // Navigate to login screen if the user is not logged in
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/login'); // Go to login route
          });
        }
        return const SizedBox.shrink(); // Placeholder while navigating
      },
    );
  }
}
