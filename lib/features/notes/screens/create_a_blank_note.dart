import 'package:writing_app/features/notes/models/character_note.dart';
import 'package:writing_app/features/notes/models/note.dart';
import 'package:writing_app/features/notes/models/simple_note.dart';
import 'package:writing_app/features/notes/models/worldbuilding_note.dart';

Future<Note> createBlankNote(String type, List<Note> cachedNotes) async {
  final now = DateTime.now();
  const defaultImage = 'assets/images/placeholder.png';

  // Determine the next position based on the cached notes
  final nextPosition = cachedNotes.isEmpty
      ? 0
      : cachedNotes
              .map((note) => note.position)
              .reduce((a, b) => a > b ? a : b) +
          1;

  switch (type) {
    case 'SimpleNote':
      return SimpleNote(
        '',
        id: '', // Generate or pass a valid unique ID
        createdAt: now,
        title: '',
        imageUrl: defaultImage,
      );
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
    default:
      throw Exception('Unsupported note type');
  }
}
