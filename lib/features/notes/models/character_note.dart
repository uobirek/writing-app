import 'package:writing_app/features/notes/models/note.dart';
import 'package:writing_app/features/notes/screens/details/character_note_details.dart';
import 'package:writing_app/features/notes/screens/details/note_details.dart';
import 'package:writing_app/features/notes/screens/editing/character_note_editing.dart';
import 'package:writing_app/features/notes/screens/editing/note_editing.dart';

class CharacterNote extends Note {
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
  }) : super(category: 'Characters', title: name);
  factory CharacterNote.fromJson(Map<String, dynamic> json) {
    return CharacterNote(
      id: json['id'] as String? ?? '', // Explicitly cast to String?
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(), // Handle invalid/missing DateTime
      name: json['name'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      age: (json['age'] as num?)?.toInt() ?? 0, // Convert num to int safely
      role: json['role'] as String? ?? '',
      eyeColor: json['eyeColor'] as String?, // Nullable field
      hairColor: json['hairColor'] as String?,
      skinColor: json['skinColor'] as String?,
      fashionStyle: json['fashionStyle'] as String?,
      distinguishingFeatures: (json['distinguishingFeatures'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      keyFamilyMembers: (json['keyFamilyMembers'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      notableEvents: (json['notableEvents'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      traits: (json['traits'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      hobbiesSkills: (json['hobbiesSkills'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      otherPersonalityDetails: json['otherPersonalityDetails'] as String?,
      goals: (json['goals'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      internalConflicts: (json['internalConflicts'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      externalConflicts: (json['externalConflicts'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      coreValues: (json['coreValues'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      imageUrl: json['imageUrl'] as String? ??
          json['image'] as String? ??
          'assets/images/placeholder.jpg',
      position: (json['position'] as num?)?.toInt() ?? 0,
    );
  }

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
      'category': category,
    };
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
