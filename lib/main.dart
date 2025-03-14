import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:writing_app/core/router.dart';
import 'package:writing_app/core/theme.dart';
import 'package:writing_app/features/notes/cubit/note_cubit.dart';
import 'package:writing_app/features/notes/repositories/note_repository.dart';
import 'package:writing_app/features/projects/cubit/project_cubit.dart';
import 'package:writing_app/features/projects/repositories/project_repository.dart';
import 'package:writing_app/features/writing/cubit/chapter_cubit.dart';
import 'package:writing_app/features/writing/repositories/chapter_repository.dart';
import 'package:writing_app/firebase_options.dart';
import 'package:writing_app/l10n/app_localizations.dart';
import 'package:writing_app/locale_provider.dart';
import 'package:writing_app/theme_cubit.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: dotenv.env['FIREBASE_API_KEY']!,
      appId: dotenv.env['FIREBASE_APP_ID']!,
      messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
      projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
      storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET']!,
    ),
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
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
            return ProjectCubit(ProjectRepository());
          },
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
          child: const MyApp(),
        ),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;
              return BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, themeMode) {
                  return MaterialApp.router(
                    locale: localeProvider.locale,
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('en'),
                      Locale('es'),
                      Locale('pl'),
                    ],
                    themeMode: themeMode,
                    theme: GlobalThemeData.lightThemeData(
                      context,
                      isMobile,
                    ),
                    darkTheme: GlobalThemeData.darkThemeData(
                      context,
                      isMobile,
                    ),
                    title: 'Writing App',
                    routerConfig: AppRouter.router,
                  );
                },
              );
            },
          );
        },
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
          final userId = snapshot.data?.uid ?? '';
          if (userId.isNotEmpty) {
            context.read<ProjectCubit>().fetchProjects(userId);
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/projects');
          });

          return const SizedBox.shrink();
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/login');
          });
          return const SizedBox.shrink();
        }
      },
    );
  }
}
