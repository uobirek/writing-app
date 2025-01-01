import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/models/character_note.dart';
import 'package:writing_app/screens/notes/note_details/note_details.dart';

class CharacterNoteDetails implements NoteDetails {
  final CharacterNote note;
  CharacterNoteDetails(this.note);

  @override
  Widget buildDetailsScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Name"),
            Text(note.name, style: _infoTextStyle),
            const SizedBox(height: 10),
            _sectionTitle("Role"),
            Text(note.role, style: _infoTextStyle),
            const SizedBox(height: 10),
            _sectionTitle("Gender"),
            Text(note.gender, style: _infoTextStyle),
            const SizedBox(height: 10),
            _sectionTitle("Age"),
            Text(note.age.toString(), style: _infoTextStyle),
            const SizedBox(height: 10),
            _sectionTitle("Physical Appearance"),
            _buildAppearanceDetails(),
            const SizedBox(height: 10),
            _sectionTitle("Personality Traits"),
            Wrap(
              spacing: 8,
              children: note.traits!
                  .map((trait) => Chip(
                        label: Text(trait),
                        backgroundColor: Colors.blue[50],
                      ))
                  .toList(),
            ),
            const SizedBox(height: 10),
            _sectionTitle("Key Family Members"),
            Text(note.keyFamilyMembers!.isNotEmpty
                ? note.keyFamilyMembers!.join(", ")
                : "No family members listed."),
            const SizedBox(height: 10),
            _sectionTitle("Notable Events"),
            Text(note.notableEvents!.isNotEmpty
                ? note.notableEvents!.join("\n")
                : "No notable events."),
            const SizedBox(height: 10),
            _sectionTitle("Character Growth"),
            _buildCharacterGrowthDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppearanceDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Eye Color: ${note.eyeColor}"),
        Text("Hair Color: ${note.hairColor}"),
        Text("Skin Color: ${note.skinColor}"),
        Text("Fashion Style: ${note.fashionStyle}"),
        if (note.distinguishingFeatures!.isNotEmpty)
          Text(
              "Distinguishing Features: ${note.distinguishingFeatures?.join(', ')}"),
      ],
    );
  }

  Widget _buildCharacterGrowthDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Goals"),
        Text(note.goals!.isNotEmpty
            ? note.goals!.join("\n")
            : "No goals specified."),
        const SizedBox(height: 10),
        _sectionTitle("Internal Conflicts"),
        Text(note.internalConflicts!.isNotEmpty
            ? note.internalConflicts!.join("\n")
            : "No internal conflicts specified."),
        const SizedBox(height: 10),
        _sectionTitle("External Conflicts"),
        Text(note.externalConflicts!.isNotEmpty
            ? note.externalConflicts!.join("\n")
            : "No external conflicts specified."),
        const SizedBox(height: 10),
        _sectionTitle("Core Values"),
        Text(note.coreValues!.isNotEmpty
            ? note.coreValues!.join(", ")
            : "No core values specified."),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  final TextStyle _infoTextStyle = const TextStyle(
    fontSize: 16,
    color: Colors.black87,
  );
}
