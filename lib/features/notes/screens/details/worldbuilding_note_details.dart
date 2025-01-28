import 'package:flutter/material.dart';
import 'package:writing_app/features/notes/models/worldbuilding_note.dart';
import 'package:writing_app/features/notes/screens/details/note_details.dart';
import 'package:writing_app/l10n/app_localizations.dart';

class WorldbuildingNoteDetails implements NoteDetails {
  WorldbuildingNoteDetails(this.note);
  final WorldbuildingNote note;

  @override
  Widget buildDetailsScreen(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle(localizations!.placeName),
            Text(note.placeName, style: _infoTextStyle),
            const SizedBox(height: 10),
            _sectionTitle(localizations.geography),
            Text(note.geography ?? '', style: _infoTextStyle),
            const SizedBox(height: 10),
            _sectionTitle(localizations.culture),
            Text(note.culture ?? '', style: _infoTextStyle),
            const SizedBox(height: 10),
            _sectionTitle(localizations.pointsOfInterest),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  note.pointsOfInterest!.map((poi) => Text('- $poi')).toList(),
            ),
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

  final TextStyle _infoTextStyle = const TextStyle(
    fontSize: 16,
    color: Colors.black87,
  );
}
