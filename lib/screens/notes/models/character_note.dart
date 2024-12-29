import 'package:writing_app/screens/notes/models/note.dart';

class CharacterNote extends Note {
  final String name; // Name of the character
  final String gender; // Gender of the character
  final int age; // Age of the character
  final String role; // Role in the story (e.g., protagonist, antagonist)

  // Physical appearance
  final String eyeColor;
  final String hairColor;
  final String skinColor;
  final String fashionStyle;
  final List<String> distinguishingFeatures;

  // History
  final List<String>
      keyFamilyMembers; // Names or descriptions of key family members
  final List<String> notableEvents; // Important life events of the character

  // Personality
  final List<String> traits; // Personality traits
  final List<String> hobbiesSkills; // Hobbies and skills
  final String? otherPersonalityDetails; // Freeform personality description

  // Character growth
  final List<String> goals; // Character's goals
  final List<String> internalConflicts; // Internal struggles
  final List<String> externalConflicts; // External struggles
  final List<String> coreValues; // Fundamental values

  // Title is automatically derived from the name
  @override
  String get title => name;

  CharacterNote({
    required super.id,
    required super.createdAt,
    required String super.image,
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
}
