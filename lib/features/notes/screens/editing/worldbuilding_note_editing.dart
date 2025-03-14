import 'package:flutter/material.dart';
import 'package:writing_app/features/notes/models/worldbuilding_note.dart';
import 'package:writing_app/features/notes/screens/editing/note_editing.dart';
import 'package:writing_app/features/notes/widgets/dynamic_list_field.dart';
import 'package:writing_app/l10n/app_localizations.dart';
import 'package:writing_app/widgets/custom_text_field.dart';
import 'package:writing_app/widgets/large_text_field.dart';

class WorldbuildingNoteEditing extends NoteEditing {
  WorldbuildingNoteEditing(this.note) : super(note.imageUrl) {
    placeNameController = TextEditingController(text: note.placeName);
    geographyController = TextEditingController(text: note.geography);
    cultureController = TextEditingController(text: note.culture);
    pointsOfInterest = note.pointsOfInterest ?? [];
  }
  final WorldbuildingNote note;
  late TextEditingController placeNameController;
  late TextEditingController geographyController;
  late TextEditingController cultureController;
  late List<String> pointsOfInterest;

  @override
  Widget buildDetailsForm(GlobalKey<FormState> formKey, BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildImageField(context),
          const SizedBox(height: 16),
          CustomTextField(
            controller: placeNameController,
            label: localizations!.placeName,
          ),
          LargeTextField(
            controller: geographyController,
            label: localizations.geography,
          ),
          LargeTextField(
            controller: cultureController,
            label: localizations.culture,
          ),
          const SizedBox(height: 16),
          DynamicListField(
            context: context,
            label: localizations.pointsOfInterest,
            list: pointsOfInterest,
          ),
        ],
      ),
    );
  }

  @override
  WorldbuildingNote buildUpdatedNote() {
    return WorldbuildingNote(
      id: note.id,
      title: placeNameController.text,
      position: note.position,
      createdAt: note.createdAt,
      imageUrl: imagePath ?? 'assets/images/placeholder.jpg',
      placeName: placeNameController.text,
      geography: geographyController.text,
      culture: cultureController.text,
      pointsOfInterest:
          pointsOfInterest.where((item) => item.isNotEmpty).toList(),
    );
  }
}
