import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/editing/note_editing.dart';
import 'package:writing_app/screens/notes/models/worldbuilding_note.dart';
import 'package:writing_app/screens/notes/widgets/custom_text_field.dart';
import 'package:writing_app/screens/notes/widgets/dynamic_list_field.dart';

class WorldbuildingNoteEditing extends NoteEditing {
  final WorldbuildingNote note;
  late TextEditingController placeNameController;
  late TextEditingController geographyController;
  late TextEditingController cultureController;
  late List<String> pointsOfInterest; // Dynamic list

  WorldbuildingNoteEditing(this.note) : super(note.imageUrl) {
    placeNameController = TextEditingController(text: note.placeName);
    geographyController = TextEditingController(text: note.geography);
    cultureController = TextEditingController(text: note.culture);
    pointsOfInterest = note.pointsOfInterest ?? []; // Initialize dynamically
  }

  @override
  Widget buildDetailsForm(GlobalKey<FormState> formKey, BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildImageField(context),
          const SizedBox(height: 16),
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
          const SizedBox(height: 16),
          DynamicListField(
              context: context,
              label: 'Points of Interest',
              list: pointsOfInterest),
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
      imageUrl: imagePath ?? 'assets/images/placeholder.png',

      placeName: placeNameController.text,
      geography: geographyController.text,
      culture: cultureController.text,
      pointsOfInterest: pointsOfInterest
          .where((item) => item.isNotEmpty)
          .toList(), // Filter out empty items
    );
  }
}
