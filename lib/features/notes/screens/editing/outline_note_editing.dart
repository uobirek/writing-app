import 'package:flutter/material.dart';
import 'package:writing_app/features/notes/models/outline_note.dart';
import 'package:writing_app/features/notes/screens/editing/note_editing.dart';
import 'package:writing_app/features/notes/widgets/dynamic_list_field.dart';
import 'package:writing_app/l10n/app_localizations.dart';
import 'package:writing_app/widgets/custom_text_field.dart';
import 'package:writing_app/widgets/large_text_field.dart';
import 'package:writing_app/widgets/minimal_text_field.dart';

class OutlineNoteEditing extends NoteEditing {
  OutlineNoteEditing(this.note) : super(note.imageUrl) {
    genreController = TextEditingController(text: note.genre);
    themes = note.themes ?? [];
    acts = note.acts
        .map(
          (act) => Act(
            heading: act.heading,
            summary: act.summary,
            plotPoints: act.plotPoints.toList(),
          ),
        )
        .toList();
    conflicts = note.conflicts ?? [];
    subplots = note.subplots ?? [];
    notes = note.notes ?? [];
  }

  final OutlineNote note;

  late TextEditingController genreController;
  late List<String> themes;
  late List<Act> acts;
  late List<String> conflicts;
  late List<String> subplots;
  late List<String> notes;

  @override
  Widget buildDetailsForm(GlobalKey<FormState> formKey, BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImageField(context),
            const SizedBox(height: 16),

            // Genre Section
            CustomTextField(
              controller: genreController,
              label: localizations!.genre,
            ),
            const SizedBox(height: 16),

            // Themes Section
            DynamicListField(
              context: context,
              label: localizations.themes,
              list: themes,
            ),
            const SizedBox(height: 16),

            // Acts Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.acts,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ...acts.map((act) {
                  final headingController =
                      TextEditingController(text: act.heading);
                  final summaryController =
                      TextEditingController(text: act.summary);

                  return Column(
                    children: [
                      MinimalTextField(
                        controller: headingController,
                        hintText: 'Act Heading...',
                        textStyle: Theme.of(context).textTheme.titleMedium,
                      ),
                      LargeTextField(
                        controller: summaryController,
                        label: 'Act Summary',
                      ),
                      DynamicListField(
                        context: context,
                        label: 'Plot Points',
                        list: act.plotPoints,
                      ),
                      const Divider(),
                    ],
                  );
                }),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Add a new Act
                acts.add(Act(heading: '', plotPoints: []));
                (context as Element).markNeedsBuild(); // Trigger UI update
              },
              child: const Text('Add Act'),
            ),

            const SizedBox(height: 16),

            // Conflicts Section
            DynamicListField(
              context: context,
              label: localizations.conflicts,
              list: conflicts,
            ),
            const SizedBox(height: 16),

            // Subplots Section
            DynamicListField(
              context: context,
              label: localizations.subplots,
              list: subplots,
            ),
            const SizedBox(height: 16),

            // Notes Section
            DynamicListField(
              context: context,
              label: localizations.notes,
              list: notes,
            ),
          ],
        ),
      ),
    );
  }

  @override
  OutlineNote buildUpdatedNote() {
    // Update each act's heading and summary
    for (int i = 0; i < acts.length; i++) {
      acts[i].heading = acts[i].heading;
      acts[i].summary = acts[i].summary;
    }

    return OutlineNote(
      id: note.id,
      createdAt: note.createdAt,
      position: note.position,
      imageUrl: imagePath ?? 'assets/images/placeholder.png',
      genre: genreController.text,
      themes: themes.where((item) => item.isNotEmpty).toList(),
      acts: acts,
      conflicts: conflicts.where((item) => item.isNotEmpty).toList(),
      subplots: subplots.where((item) => item.isNotEmpty).toList(),
      notes: notes.where((item) => item.isNotEmpty).toList(),
    );
  }
}
