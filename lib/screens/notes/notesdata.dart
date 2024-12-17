import 'package:writing_app/screens/notes/note.dart';

final List<Note> notes = [
  Note(
    id: '1',
    title: 'Resort',
    content: 'This is a note about worldbuilding basics.',
    category: 'Worldbuilding',
    image: 'assets/images/resort.jpg', // Placeholder image path
    createdAt: DateTime.now(),
  ),
  Note(
    id: '2',
    title: 'Dottie',
    content: 'This note focuses on developing characters.',
    category: 'Characters',
    image: 'assets/images/dottie.jpg',
    createdAt: DateTime.now(),
  ),
  Note(
    id: '3',
    title: 'Georgia',
    content: 'This note focuses on developing characters.',
    category: 'Characters',
    image: 'assets/images/georgia.jpg',
    createdAt: DateTime.now(),
  ),
  Note(
    id: '4',
    title: 'I.C. Loveless',
    content: 'This note focuses on developing characters.',
    category: 'Characters',
    image: 'assets/images/inclementia.jpg',
    createdAt: DateTime.now(),
  ),
];
