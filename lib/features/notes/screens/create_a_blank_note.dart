import 'package:flutter/material.dart';
import 'package:writing_app/features/notes/models/character_note.dart';
import 'package:writing_app/features/notes/models/note.dart';
import 'package:writing_app/features/notes/models/outline_note.dart';
import 'package:writing_app/features/notes/models/worldbuilding_note.dart';
import 'package:writing_app/l10n/app_localizations.dart';

Future<Note> createBlankNote(
  String type,
  List<Note> cachedNotes,
  BuildContext context,
) async {
  final now = DateTime.now();
  const defaultImage = 'assets/images/placeholder.png';
  final localizations = AppLocalizations.of(context);

  // Determine the next position based on the cached notes
  final nextPosition = cachedNotes.isEmpty
      ? 0
      : cachedNotes
              .map((note) => note.position)
              .reduce((a, b) => a > b ? a : b) +
          1;

  switch (type) {
    case 'CharacterNote':
      return CharacterNote(
        id: '',
        createdAt: now,
        imageUrl: defaultImage,
        name: '',
        role: '',
        gender: '',
        age: 0,
        eyeColor: '',
        hairColor: '',
        skinColor: '',
        fashionStyle: '',
        distinguishingFeatures: [],
        traits: [],
        hobbiesSkills: [],
        keyFamilyMembers: [],
        notableEvents: [],
        goals: [],
        internalConflicts: [],
        externalConflicts: [],
        coreValues: [],
        position: nextPosition,
      );
    case 'WorldbuildingNote':
      return WorldbuildingNote(
        id: '',
        createdAt: now,
        imageUrl: defaultImage,
        title: '',
        placeName: '',
        geography: '',
        culture: '',
        pointsOfInterest: [],
        position: nextPosition,
      );
    case 'OutlineNote':
      return OutlineNote(
        id: '',
        createdAt: now,
        imageUrl: defaultImage,
        genre: '',
        themes: [],
        acts: [],
        conflicts: [],
        subplots: [],
        notes: [],
        position: nextPosition,
      );
    default:
      throw Exception(localizations!.unsupportedNoteType);
  }
}
