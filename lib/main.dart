import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:writing_app/data/notes_data.dart';
import 'package:writing_app/firebase_options.dart';
import 'package:writing_app/screens/notes/bloc/note_cubit.dart';
import 'package:writing_app/screens/notes/models/character_note.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/models/worldbuilding_note.dart';
import 'package:writing_app/screens/notes/repositories/note_repository.dart';
import 'package:writing_app/screens/notes/services/firebase_service.dart';
import 'package:writing_app/utils/router.dart';
import 'package:writing_app/utils/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

Future<void> addNote(Note note) async {
  final firestore = FirebaseFirestore.instance;

  try {
    await firestore.collection('notes').doc(note.id).set(note.toJson());
    print('Note added successfully!');
  } catch (e) {
    print('Error adding note: $e');
  }
}

Future<void> createNoteCollection(
    String noteId, Map<String, dynamic> noteData) async {
  final firestore = FirebaseFirestore.instance;

  try {
    // Adds a new document to the 'notes' collection with the specified noteId
    await firestore.collection('notes').doc(noteId).set(noteData);
    print('Collection and document created successfully!');
  } catch (e) {
    print('Error creating collection/document: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteCubit(NoteRepository()),
      child: MaterialApp.router(
        themeMode: ThemeMode.light,
        theme: GlobalThemeData.lightThemeData,
        darkTheme: GlobalThemeData.darkThemeData,
        title: 'Writing App',
        routerConfig: AppRouter.router, // Use the GoRouter configuration
      ),
    );
  }
}

Future<void> migrateAllNotesToFirestore() async {
  final FirebaseService firebaseService = FirebaseService();

  for (final note in notes) {
    try {
      // Save the note to Firestore
      await firebaseService.saveNote(note);
      print("Successfully migrated note with ID: ${note.id}");
    } catch (e) {
      print("Failed to migrate note with ID: ${note.id}. Error: $e");
    }
  }

  print("Migration completed!");
}
