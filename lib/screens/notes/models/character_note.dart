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
    String super.imageUrl = 'assets/images/placeholder.jpg',
    required this.name,
    required this.gender,
    required this.age,
    required this.role,
    this.eyeColor,
    this.hairColor,
    this.skinColor,
    this.fashionStyle,
    this.distinguishingFeatures,
    required this.keyFamilyMembers,
    required this.notableEvents,
    required this.traits,
    required this.hobbiesSkills,
    this.otherPersonalityDetails,
    required this.goals,
    required this.internalConflicts,
    required this.externalConflicts,
    required this.coreValues,
    required super.position,
  }) : super(category: "Characters", title: name);
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'position': position,
      'name': name,
      'gender': gender,
      'age': age,
      'role': role,
      'eyeColor': eyeColor,
      'hairColor': hairColor,
      'skinColor': skinColor,
      'fashionStyle': fashionStyle,
      'distinguishingFeatures': distinguishingFeatures ?? [],
      'keyFamilyMembers': keyFamilyMembers ?? [],
      'notableEvents': notableEvents ?? [],
      'traits': traits ?? [],
      'hobbiesSkills': hobbiesSkills ?? [],
      'otherPersonalityDetails': otherPersonalityDetails,
      'goals': goals ?? [],
      'internalConflicts': internalConflicts ?? [],
      'externalConflicts': externalConflicts ?? [],
      'coreValues': coreValues ?? [],
      'image': imageUrl,
      'type': 'CharacterNote',
      'category': category
    };
  }

  factory CharacterNote.fromJson(Map<String, dynamic> json) {
    return CharacterNote(
      id: json['id'] ?? '', // Provide a default empty string if `id` is null
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      name: json['name'] ?? '',
      gender: json['gender'] ?? '',
      age: json['age'] ?? 0, // Default to 0 if `age` is null
      role: json['role'] ?? '',
      eyeColor: json['eyeColor'], // Optional field can remain nullable
      hairColor: json['hairColor'],
      skinColor: json['skinColor'],
      fashionStyle: json['fashionStyle'],
      distinguishingFeatures: json['distinguishingFeatures'] != null
          ? List<String>.from(json['distinguishingFeatures'])
          : [],
      keyFamilyMembers: json['keyFamilyMembers'] != null
          ? List<String>.from(json['keyFamilyMembers'])
          : [],
      notableEvents: json['notableEvents'] != null
          ? List<String>.from(json['notableEvents'])
          : [],
      traits: json['traits'] != null ? List<String>.from(json['traits']) : [],
      hobbiesSkills: json['hobbiesSkills'] != null
          ? List<String>.from(json['hobbiesSkills'])
          : [],
      otherPersonalityDetails: json['otherPersonalityDetails'],
      goals: json['goals'] != null ? List<String>.from(json['goals']) : [],
      internalConflicts: json['internalConflicts'] != null
          ? List<String>.from(json['internalConflicts'])
          : [],
      externalConflicts: json['externalConflicts'] != null
          ? List<String>.from(json['externalConflicts'])
          : [],
      coreValues: json['coreValues'] != null
          ? List<String>.from(json['coreValues'])
          : [],
      imageUrl:
          json['imageUrl'] ?? json['image'] ?? 'assets/images/placeholder.jpg',
      position: json['position'],
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
