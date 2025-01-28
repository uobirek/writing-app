import 'package:flutter/material.dart';
import 'package:writing_app/features/notes/models/outline_note.dart';
import 'package:writing_app/features/notes/screens/details/note_details.dart';
import 'package:writing_app/l10n/app_localizations.dart';

class OutlineNoteDetails implements NoteDetails {
  OutlineNoteDetails(this.note);
  final OutlineNote note;

  @override
  Widget buildDetailsScreen(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (note.genre != null) ...[
              _sectionTitle(localizations!.genre),
              Text(note.genre ?? '', style: _infoTextStyle),
              const SizedBox(height: 10),
            ],
            _sectionTitle(localizations!.themes),
            _listSection(note.themes, context),
            const SizedBox(height: 10),
            _sectionTitle(localizations.acts),
            _actsSection(note.acts, context),
            const SizedBox(height: 10),
            _sectionTitle(localizations.conflicts),
            _listSection(note.conflicts, context),
            const SizedBox(height: 10),
            _sectionTitle(localizations.subplots),
            _listSection(note.subplots, context),
            const SizedBox(height: 10),
            _sectionTitle(localizations.notes),
            _listSection(note.notes, context),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _listSection(List<String> items, BuildContext context) {
    final localizations = AppLocalizations.of(context);

    if (items.isEmpty) {
      return Text(localizations!.none, style: _infoTextStyle);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          items.map((item) => Text('- $item', style: _infoTextStyle)).toList(),
    );
  }

  Widget _actsSection(List<Act> acts, BuildContext context) {
    final localizations = AppLocalizations.of(context);

    if (acts.isEmpty) {
      return Text(localizations!.noActsAvailable, style: _infoTextStyle);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: acts.map((act) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              act.heading,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            if (act.summary.isNotEmpty)
              Text(act.summary, style: _infoTextStyle),
            if (act.plotPoints.isNotEmpty)
              _listSection(act.plotPoints, context),
            const SizedBox(height: 10),
          ],
        );
      }).toList(),
    );
  }

  final TextStyle _infoTextStyle = const TextStyle(
    fontSize: 16,
    color: Colors.black87,
  );
}
