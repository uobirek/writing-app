import 'package:flutter/material.dart';
import 'package:writing_app/features/notes/models/character_note.dart';
import 'package:writing_app/features/notes/screens/details/note_details.dart';
import 'package:writing_app/l10n/app_localizations.dart';

class CharacterNoteDetails implements NoteDetails {
  CharacterNoteDetails(this.note);
  final CharacterNote note;

  @override
  Widget buildDetailsScreen(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(context, localizations!.name, note.name),
            _buildSection(context, localizations.role, note.role),
            _buildSection(context, localizations.gender, note.gender),
            _buildSection(context, localizations.age, note.age.toString()),
            _buildAppearanceSection(context),
            _buildTraitsSection(context),
            _buildSection(
              context,
              localizations.hobbiesAndSkills,
              _listToString(note.hobbiesSkills, context),
            ),
            _buildSection(
              context,
              localizations.otherPersonalityDetails,
              note.otherPersonalityDetails ?? localizations.notSpecified,
            ),
            _buildSection(
              context,
              localizations.keyFamilyMembers,
              _listToString(note.keyFamilyMembers, context),
            ),
            _buildSection(
              context,
              localizations.notableEvents,
              _listToString(note.notableEvents, context),
            ),
            _buildCharacterGrowthSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAppearanceSection(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return _buildSectionWithChildren(
      localizations!.physicalAppearance,
      [
        _infoRow(
          localizations.eyeColor,
          note.eyeColor ?? localizations.notSpecified,
        ),
        _infoRow(
          localizations.hairColor,
          note.hairColor ?? localizations.notSpecified,
        ),
        _infoRow(
          localizations.skinColor,
          note.skinColor ?? localizations.notSpecified,
        ),
        _infoRow(
          localizations.fashionStyle,
          note.fashionStyle ?? localizations.notSpecified,
        ),
        if (note.distinguishingFeatures != null &&
            note.distinguishingFeatures!.isNotEmpty)
          _infoRow(
            localizations.distinguishingFeatures,
            note.distinguishingFeatures!.join(', '),
          )
        else
          _infoRow(
            localizations.distinguishingFeatures,
            localizations.notSpecified,
          ),
      ],
    );
  }

  Widget _buildTraitsSection(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return _buildSectionWithChildren(
      localizations!.personalityTraits,
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
          Text(
            localizations.notSpecified,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
      ],
    );
  }

  Widget _buildCharacterGrowthSection(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return _buildSectionWithChildren(
      localizations!.characterGrowth,
      [
        _buildSection(
          context,
          localizations.goals,
          _listToString(note.goals, context),
        ),
        _buildSection(
          context,
          localizations.internalConflicts,
          _listToString(note.internalConflicts, context),
        ),
        _buildSection(
          context,
          localizations.externalConflicts,
          _listToString(note.externalConflicts, context),
        ),
        _buildSection(
          context,
          localizations.coreValues,
          _listToString(note.coreValues, context),
        ),
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

  String _listToString(List<String>? list, BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return (list == null || list.isEmpty)
        ? localizations!.notSpecified
        : list.join(', ');
  }
}
