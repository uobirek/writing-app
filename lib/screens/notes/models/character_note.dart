import 'package:writing_app/screens/notes/editing/character_note_editing.dart';
import 'package:writing_app/screens/notes/editing/note_editing.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/note_details/character_note_details.dart';
import 'package:writing_app/screens/notes/note_details/note_details.dart';

class CharacterNote extends Note {
  final String name;
  final String gender;
  final int age;
  final String role; // Role in the story (e.g., protagonist, antagonist)

  // Physical appearance
  final String? eyeColor;
  final String? hairColor;
  final String? skinColor;
  final String? fashionStyle;
  final List<String>? distinguishingFeatures;

  // History
  final List<String>? keyFamilyMembers;
  final List<String>? notableEvents;

  // Personality
  final List<String>? traits;
  final List<String>? hobbiesSkills;
  final String? otherPersonalityDetails;

  // Character growth
  final List<String>? goals;
  final List<String>? internalConflicts;
  final List<String>? externalConflicts;
  final List<String>? coreValues;

  // Title is automatically derived from the name
  @override
  String get title => name;

  CharacterNote({
    required super.id,
    required super.createdAt,
    String super.image = 'assets/images/placeholder.jpg',
    required this.name,
    required this.gender,
    required this.age,
    required this.role,
    required this.eyeColor,
    required this.hairColor,
    required this.skinColor,
    required this.fashionStyle,
    required this.distinguishingFeatures,
    required this.keyFamilyMembers,
    required this.notableEvents,
    required this.traits,
    required this.hobbiesSkills,
    this.otherPersonalityDetails,
    required this.goals,
    required this.internalConflicts,
    required this.externalConflicts,
    required this.coreValues,
  }) : super(category: "Characters", title: name);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title, // Automatically set to name
      'createdAt': createdAt.toIso8601String(),
      'name': name,
      'gender': gender,
      'age': age,
      'role': role,
      'eyeColor': eyeColor,
      'hairColor': hairColor,
      'skinColor': skinColor,
      'fashionStyle': fashionStyle,
      'distinguishingFeatures': distinguishingFeatures,
      'keyFamilyMembers': keyFamilyMembers,
      'notableEvents': notableEvents,
      'traits': traits,
      'hobbiesSkills': hobbiesSkills,
      'otherPersonalityDetails': otherPersonalityDetails,
      'goals': goals,
      'internalConflicts': internalConflicts,
      'externalConflicts': externalConflicts,
      'coreValues': coreValues,
      'image': image,
      'type': 'CharacterNote',
    };
  }

  factory CharacterNote.fromJson(Map<String, dynamic> json) {
    return CharacterNote(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      name: json['name'],
      gender: json['gender'],
      age: json['age'],
      role: json['role'],
      eyeColor: json['eyeColor'],
      hairColor: json['hairColor'],
      skinColor: json['skinColor'],
      fashionStyle: json['fashionStyle'],
      distinguishingFeatures: List<String>.from(json['distinguishingFeatures']),
      keyFamilyMembers: List<String>.from(json['keyFamilyMembers']),
      notableEvents: List<String>.from(json['notableEvents']),
      traits: List<String>.from(json['traits']),
      hobbiesSkills: List<String>.from(json['hobbiesSkills']),
      otherPersonalityDetails: json['otherPersonalityDetails'],
      goals: List<String>.from(json['goals']),
      internalConflicts: List<String>.from(json['internalConflicts']),
      externalConflicts: List<String>.from(json['externalConflicts']),
      coreValues: List<String>.from(json['coreValues']),
      image: json['image'],
    );
  }
  @override
  NoteDetails getNoteDetails() {
    return CharacterNoteDetails(this);
  }

  @override
  NoteEditing getNoteEditing() {
    return CharacterNoteEditing(this);
  }
}
