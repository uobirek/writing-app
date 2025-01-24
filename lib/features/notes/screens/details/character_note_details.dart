import 'package:flutter/material.dart';
import 'package:writing_app/features/notes/models/character_note.dart';
import 'package:writing_app/features/notes/screens/details/note_details.dart';

class CharacterNoteDetails implements NoteDetails {
  CharacterNoteDetails(this.note);
  final CharacterNote note;

  @override
  Widget buildDetailsScreen(BuildContext context) {
    Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(context, 'Name', note.name),
              _buildSection(context, 'Role', note.role),
              _buildSection(context, 'Gender', note.gender),
              _buildSection(context, 'Age', note.age.toString()),
              _buildAppearanceSection(),
              _buildTraitsSection(context),
              _buildSection(
                context,
                'Key Family Members',
                _listToString(note.keyFamilyMembers),
              ),
              _buildSection(
                context,
                'Notable Events',
                _listToString(note.notableEvents),
              ),
              _buildCharacterGrowthSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppearanceSection() {
    return _buildSectionWithChildren(
      'Physical Appearance',
      [
        _infoRow('Eye Color', note.eyeColor ?? 'Not specified'),
        _infoRow('Hair Color', note.hairColor ?? 'Not specified'),
        _infoRow('Skin Color', note.skinColor ?? 'Not specified'),
        _infoRow('Fashion Style', note.fashionStyle ?? 'Not specified'),
        if (note.distinguishingFeatures != null &&
            note.distinguishingFeatures!.isNotEmpty)
          _infoRow(
            'Distinguishing Features',
            note.distinguishingFeatures!.join(', '),
          )
        else
          _infoRow('Distinguishing Features', 'Not specified'),
      ],
    );
  }

  Widget _buildTraitsSection(BuildContext context) {
    return _buildSectionWithChildren(
      'Personality Traits',
      [
        if (note.traits != null && note.traits!.isNotEmpty)
          Wrap(
            spacing: 8,
            children: note.traits!
                .map(
                  (trait) => Chip(
                    label: Text(trait),
                    backgroundColor:
                        Theme.of(context).colorScheme.secondary.withAlpha(50),
                  ),
                )
                .toList(),
          )
        else
          Text('Not specified', style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildCharacterGrowthSection(BuildContext context) {
    return _buildSectionWithChildren(
      'Character Growth',
      [
        _buildSection(context, 'Goals', _listToString(note.goals)),
        _buildSection(
          context,
          'Internal Conflicts',
          _listToString(note.internalConflicts),
        ),
        _buildSection(
          context,
          'External Conflicts',
          _listToString(note.externalConflicts),
        ),
        _buildSection(context, 'Core Values', _listToString(note.coreValues)),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 4),
          Text(content, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildSectionWithChildren(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  String _listToString(List<String>? list) {
    return (list == null || list.isEmpty) ? 'Not specified' : list.join(', ');
  }
}
