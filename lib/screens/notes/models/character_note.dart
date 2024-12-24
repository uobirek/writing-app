import 'package:writing_app/screens/notes/models/note.dart';

class CharacterNote extends Note {
  final String name; // Name of the character
  final String role; // Role in the story (e.g., protagonist, antagonist)
  final String description; // Physical or personality description
  final List<String> traits; // List of character traits

  CharacterNote({
    required super.id,
    required super.title,
    required super.createdAt,
    required String super.image,
    required this.name,
    required this.role,
    required this.description,
    required this.traits,
  }) : super(category: "Characters");

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
