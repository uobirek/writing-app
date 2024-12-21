import 'package:writing_app/screens/notes/models/character_note.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/models/worldbuilding_note.dart';

final List<Note> notes = [
  // Worldbuilding Notes
  WorldbuildingNote(
    id: '1',
    title: 'Resort Island',
    createdAt: DateTime.now(),
    image: 'assets/images/resort.jpg', // Placeholder image path
    placeName: 'Resort Island',
    geography: 'A tropical island surrounded by crystal-clear waters.',
    culture: 'Relaxed island life with a focus on hospitality and tourism.',
    pointsOfInterest: [
      'Luxury Beach',
      'Ancient Lighthouse',
      'Underground Caves'
    ],
  ),

  // Character Notes
  CharacterNote(
    id: '3',
    title: 'Dottie',
    createdAt: DateTime.now(),
    image: 'assets/images/dottie.jpg',
    name: 'Dottie',
    role: 'Protagonist',
    description: 'A courageous and curious young adventurer.',
    traits: ['Brave', 'Curious', 'Optimistic'],
  ),
  CharacterNote(
    id: '4',
    title: 'Georgia',
    createdAt: DateTime.now(),
    image: 'assets/images/georgia.jpg',
    name: 'Georgia',
    role: 'Supporting Character',
    description: 'A loyal friend with a sharp wit and a quick temper.',
    traits: ['Loyal', 'Witty', 'Impulsive'],
  ),
  CharacterNote(
    id: '5',
    title: 'I.C. Loveless',
    createdAt: DateTime.now(),
    image: 'assets/images/inclementia.jpg',
    name: 'I.C. Loveless',
    role: 'Antagonist',
    description: 'A cunning villain with a mysterious past.',
    traits: ['Manipulative', 'Clever', 'Resilient'],
  ),
  CharacterNote(
    id: '6',
    title: 'Giovanni',
    createdAt: DateTime.now(),
    image: 'assets/images/giovanni.jpg',
    name: 'Giovanni',
    role: 'Mentor',
    description: 'A wise mentor who guides the protagonist.',
    traits: ['Wise', 'Kind', 'Patient'],
  ),
  CharacterNote(
    id: '7',
    title: 'Zachariah Fleury',
    createdAt: DateTime.now(),
    image: 'assets/images/zach.jpg',
    name: 'Zachariah Fleury',
    role: 'Rogue Ally',
    description: 'A charming rogue with a hidden agenda.',
    traits: ['Charming', 'Unpredictable', 'Resourceful'],
  ),
];
