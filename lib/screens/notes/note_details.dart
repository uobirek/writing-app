import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/models/character_note.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/models/worldbuilding_note.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class NoteDetailsScreen extends StatelessWidget {
  final Note note;

  const NoteDetailsScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return SidebarLayout(
      activeRoute: "/notes",
      child: Scaffold(
        appBar: AppBar(
          title: Text(note.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Note Image
                if (note.image != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      note.image!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 20),
                // Note Details
                if (note is CharacterNote)
                  _buildCharacterDetails(note as CharacterNote)
                else if (note is WorldbuildingNote)
                  _buildWorldbuildingDetails(note as WorldbuildingNote)
                else
                  const Text("Details unavailable for this note type."),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Character Note Details
  Widget _buildCharacterDetails(CharacterNote note) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Name: ${note.name}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          "Role: ${note.role}",
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        const Text(
          "Description:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(note.description),
        const SizedBox(height: 10),
        const Text(
          "Traits:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Wrap(
          spacing: 8,
          children: note.traits
              .map((trait) => Chip(
                    label: Text(trait),
                    backgroundColor: Colors.blue[50],
                  ))
              .toList(),
        ),
      ],
    );
  }

  // Worldbuilding Note Details
  Widget _buildWorldbuildingDetails(WorldbuildingNote note) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Place Name: ${note.placeName}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          "Geography:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(note.geography),
        const SizedBox(height: 10),
        const Text(
          "Culture:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(note.culture),
        const SizedBox(height: 10),
        const Text(
          "Points of Interest:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: note.pointsOfInterest.map((poi) => Text("- $poi")).toList(),
        ),
      ],
    );
  }
}
