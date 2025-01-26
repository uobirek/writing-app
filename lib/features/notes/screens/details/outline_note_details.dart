import 'package:flutter/material.dart';
import 'package:writing_app/features/notes/models/outline_note.dart';
import 'package:writing_app/features/notes/screens/details/note_details.dart';

class OutlineNoteDetails implements NoteDetails {
  OutlineNoteDetails(this.note);
  final OutlineNote note;

  @override
  Widget buildDetailsScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (note.genre != null) ...[
              _sectionTitle('Genre'),
              Text(note.genre ?? '', style: _infoTextStyle),
              const SizedBox(height: 10),
            ],
            _sectionTitle('Themes'),
            _listSection(note.themes),
            const SizedBox(height: 10),
            _sectionTitle('Acts'),
            _actsSection(note.acts),
            const SizedBox(height: 10),
            _sectionTitle('Conflicts'),
            _listSection(note.conflicts),
            const SizedBox(height: 10),
            _sectionTitle('Subplots'),
            _listSection(note.subplots),
            const SizedBox(height: 10),
            _sectionTitle('Notes'),
            _listSection(note.notes),
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

  Widget _listSection(List<String> items) {
    if (items.isEmpty) {
      return Text('None', style: _infoTextStyle);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          items.map((item) => Text('- $item', style: _infoTextStyle)).toList(),
    );
  }

  Widget _actsSection(List<Act> acts) {
    if (acts.isEmpty) {
      return Text('No acts available', style: _infoTextStyle);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: acts.map((act) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(act.heading,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            if (act.summary.isNotEmpty)
              Text(act.summary, style: _infoTextStyle),
            if (act.plotPoints.isNotEmpty) _listSection(act.plotPoints),
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
