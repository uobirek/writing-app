import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/editing/note_editing.dart';
import 'package:writing_app/screens/notes/models/worldbuilding_note.dart';
import 'package:writing_app/screens/notes/widgets/custom_text_field.dart';

class WorldbuildingNoteEditing implements NoteEditing {
  final WorldbuildingNote note;
  late TextEditingController placeNameController;
  late TextEditingController geographyController;
  late TextEditingController cultureController;
  late TextEditingController pointsOfInterestController;

  WorldbuildingNoteEditing(this.note) {
    placeNameController = TextEditingController(text: note.placeName);
    geographyController = TextEditingController(text: note.geography);
    cultureController = TextEditingController(text: note.culture);
    pointsOfInterestController = TextEditingController(
      text: note.pointsOfInterest?.join(', ') ?? '',
    );
  }

  @override
  Widget buildDetailsForm(GlobalKey<FormState> formKey, BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: placeNameController,
            label: 'Place Name',
          ),
          CustomTextField(
            controller: geographyController,
            label: 'Geography Description',
          ),
          CustomTextField(
            controller: cultureController,
            label: 'Culture Description',
          ),
          CustomTextField(
            controller: pointsOfInterestController,
            label: 'Points of Interest (comma-separated)',
          ),
        ],
      ),
    );
  }

  @override
  WorldbuildingNote buildUpdatedNote() {
    return WorldbuildingNote(
      id: note.id,
      title: note.title,
      createdAt: note.createdAt,
      image: note.image ?? '',
      placeName: placeNameController.text,
      geography: geographyController.text,
      culture: cultureController.text,
      pointsOfInterest: pointsOfInterestController.text.split(', '),
    );
  }
}
