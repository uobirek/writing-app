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
                if (note.image!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      note.image ?? '',
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
        _sectionTitle("Name"),
        Text(note.name, style: _infoTextStyle),
        const SizedBox(height: 10),
        _sectionTitle("Role"),
        Text(note.role, style: _infoTextStyle),
        const SizedBox(height: 10),
        _sectionTitle("Gender"),
        Text(note.gender ?? "Not specified", style: _infoTextStyle),
        const SizedBox(height: 10),
        _sectionTitle("Age"),
        Text(note.age.toString() ?? "Not specified", style: _infoTextStyle),
        const SizedBox(height: 10),
        _sectionTitle("Physical Appearance"),
        _buildAppearanceDetails(note),
        const SizedBox(height: 10),
        _sectionTitle("Personality Traits"),
        Wrap(
          spacing: 8,
          children: note.traits
              .map((trait) => Chip(
                    label: Text(trait),
                    backgroundColor: Colors.blue[50],
                  ))
              .toList(),
        ),
        const SizedBox(height: 10),
        _sectionTitle("Key Family Members"),
        Text(note.keyFamilyMembers.isNotEmpty
            ? note.keyFamilyMembers.join(", ")
            : "No family members listed."),
        const SizedBox(height: 10),
        _sectionTitle("Notable Events"),
        Text(note.notableEvents.isNotEmpty
            ? note.notableEvents.join("\n")
            : "No notable events."),
        const SizedBox(height: 10),
        _sectionTitle("Character Growth"),
        _buildCharacterGrowthDetails(note),
      ],
    );
  }

  // Helper method to build physical appearance section
  Widget _buildAppearanceDetails(CharacterNote note) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Eye Color: ${note.eyeColor}"),
        Text("Hair Color: ${note.hairColor}"),
        Text("Skin Color: ${note.skinColor}"),
        Text("Fashion Style: ${note.fashionStyle}"),
        if (note.distinguishingFeatures.isNotEmpty)
          Text(
              "Distinguishing Features: ${note.distinguishingFeatures.join(', ')}"),
      ],
    );
  }

  // Helper method to build character growth section
  Widget _buildCharacterGrowthDetails(CharacterNote note) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Goals"),
        Text(note.goals.isNotEmpty
            ? note.goals.join("\n")
            : "No goals specified."),
        const SizedBox(height: 10),
        _sectionTitle("Internal Conflicts"),
        Text(note.internalConflicts.isNotEmpty
            ? note.internalConflicts.join("\n")
            : "No internal conflicts specified."),
        const SizedBox(height: 10),
        _sectionTitle("External Conflicts"),
        Text(note.externalConflicts.isNotEmpty
            ? note.externalConflicts.join("\n")
            : "No external conflicts specified."),
        const SizedBox(height: 10),
        _sectionTitle("Core Values"),
        Text(note.coreValues.isNotEmpty
            ? note.coreValues.join(", ")
            : "No core values specified."),
      ],
    );
  }

  // Worldbuilding Note Details
  Widget _buildWorldbuildingDetails(WorldbuildingNote note) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Place Name"),
        Text(note.placeName, style: _infoTextStyle),
        const SizedBox(height: 10),
        _sectionTitle("Geography"),
        Text(note.geography, style: _infoTextStyle),
        const SizedBox(height: 10),
        _sectionTitle("Culture"),
        Text(note.culture, style: _infoTextStyle),
        const SizedBox(height: 10),
        _sectionTitle("Points of Interest"),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: note.pointsOfInterest.map((poi) => Text("- $poi")).toList(),
        ),
      ],
    );
  }

  // Helper method for section titles
  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  // TextStyle for info text
  final TextStyle _infoTextStyle = const TextStyle(
    fontSize: 16,
    color: Colors.black87,
  );
}
