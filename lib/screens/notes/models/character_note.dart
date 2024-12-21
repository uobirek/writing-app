import 'package:writing_app/screens/notes/models/note.dart';

class CharacterNote extends Note {
  final String name; // Name of the character
  final String role; // Role in the story (e.g., protagonist, antagonist)
  final String description; // Physical or personality description
  final List<String> traits; // List of character traits

  CharacterNote({
    required String id,
    required String title,
    required DateTime createdAt,
    required String image,
    required this.name,
    required this.role,
    required this.description,
    required this.traits,
  }) : super(
            id: id,
            title: title,
            createdAt: createdAt,
            image: image,
            category: "character");

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'name': name,
      'role': role,
      'description': description,
      'traits': traits,
      'image': image,
      'type': 'CharacterNote',
    };
  }

  factory CharacterNote.fromJson(Map<String, dynamic> json) {
    return CharacterNote(
      id: json['id'],
      title: json['title'],
      createdAt: DateTime.parse(json['createdAt']),
      name: json['name'],
      role: json['role'],
      description: json['description'],
      traits: List<String>.from(json['traits']),
      image: json['image'],
    );
  }
}
