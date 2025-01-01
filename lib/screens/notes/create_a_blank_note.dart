import 'package:writing_app/screens/notes/models/character_note.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/models/simple_note.dart';
import 'package:writing_app/screens/notes/models/worldbuilding_note.dart';

Note createBlankNote(String type) {
  final now = DateTime.now();
  switch (type) {
    case 'SimpleNote':
      return SimpleNote('', id: 'new', createdAt: now, title: '', image: '');
    case 'CharacterNote':
      return CharacterNote(
        id: 'new',
        createdAt: now,
        image: '',
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
      );
    case 'WorldbuildingNote':
      return WorldbuildingNote(
        id: 'new',
        createdAt: now,
        image: '',
        title: '',
        placeName: '',
        geography: '',
        culture: '',
        pointsOfInterest: [],
      );
    default:
      throw Exception('Unsupported note type');
  }
}
