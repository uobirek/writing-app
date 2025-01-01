import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/editing/note_editing.dart';
import 'package:writing_app/screens/notes/models/character_note.dart';
import 'package:writing_app/screens/notes/widgets/custom_text_field.dart';

class CharacterNoteEditing implements NoteEditing {
  final CharacterNote note;
  late TextEditingController imageController;
  late TextEditingController nameController;
  late TextEditingController roleController;
  late TextEditingController genderController;
  late TextEditingController ageController;
  late TextEditingController eyeColorController;
  late TextEditingController hairColorController;
  late TextEditingController skinColorController;
  late TextEditingController fashionStyleController;
  late TextEditingController distinguishingFeaturesController;
  late TextEditingController traitsController;
  late TextEditingController hobbiesSkillsController;
  late TextEditingController keyFamilyMembersController;
  late TextEditingController notableEventsController;
  late TextEditingController goalsController;
  late TextEditingController internalConflictsController;
  late TextEditingController externalConflictsController;
  late TextEditingController coreValuesController;

  CharacterNoteEditing(this.note) {
    imageController = TextEditingController(text: note.image);
    nameController = TextEditingController(text: note.name);
    roleController = TextEditingController(text: note.role);
    genderController = TextEditingController(text: note.gender);
    ageController = TextEditingController(text: note.age.toString());
    eyeColorController = TextEditingController(text: note.eyeColor);
    hairColorController = TextEditingController(text: note.hairColor);
    skinColorController = TextEditingController(text: note.skinColor);
    fashionStyleController = TextEditingController(text: note.fashionStyle);
    distinguishingFeaturesController =
        TextEditingController(text: note.distinguishingFeatures?.join(', '));
    traitsController = TextEditingController(text: note.traits?.join(', '));
    hobbiesSkillsController =
        TextEditingController(text: note.hobbiesSkills?.join(', '));
    keyFamilyMembersController =
        TextEditingController(text: note.keyFamilyMembers?.join(', '));
    notableEventsController =
        TextEditingController(text: note.notableEvents?.join(', '));
    goalsController = TextEditingController(text: note.goals?.join(', '));
    internalConflictsController =
        TextEditingController(text: note.internalConflicts?.join(', '));
    externalConflictsController =
        TextEditingController(text: note.externalConflicts?.join(', '));
    coreValuesController =
        TextEditingController(text: note.coreValues?.join(', '));
  }

  @override
  Widget buildDetailsForm(GlobalKey<FormState> formKey, BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(controller: imageController, label: 'Image Url'),
          CustomTextField(controller: nameController, label: 'Name'),
          CustomTextField(controller: roleController, label: 'Role'),
          CustomTextField(controller: genderController, label: 'Gender'),
          CustomTextField(
              controller: ageController, label: 'Age', isNumber: true),
          CustomTextField(controller: eyeColorController, label: 'Eye Color'),
          CustomTextField(controller: hairColorController, label: 'Hair Color'),
          CustomTextField(controller: skinColorController, label: 'Skin Color'),
          CustomTextField(
              controller: fashionStyleController, label: 'Fashion Style'),
          CustomTextField(
              controller: distinguishingFeaturesController,
              label: 'Distinguishing Features (comma-separated)'),
          CustomTextField(
              controller: traitsController, label: 'Traits (comma-separated)'),
          CustomTextField(
              controller: hobbiesSkillsController,
              label: 'Hobbies and Skills (comma-separated)'),
          CustomTextField(
              controller: keyFamilyMembersController,
              label: 'Key Family Members (comma-separated)'),
          CustomTextField(
              controller: notableEventsController,
              label: 'Notable Events (comma-separated)'),
          CustomTextField(
              controller: goalsController, label: 'Goals (comma-separated)'),
          CustomTextField(
              controller: internalConflictsController,
              label: 'Internal Conflicts (comma-separated)'),
          CustomTextField(
              controller: externalConflictsController,
              label: 'External Conflicts (comma-separated)'),
          CustomTextField(
              controller: coreValuesController,
              label: 'Core Values (comma-separated)'),
        ],
      ),
    );
  }

  @override
  CharacterNote buildUpdatedNote() {
    return CharacterNote(
      id: note.id,
      createdAt: note.createdAt,
      image: imageController.text,
      name: nameController.text,
      role: roleController.text,
      gender: genderController.text,
      age: int.tryParse(ageController.text) ?? 0,
      eyeColor: eyeColorController.text,
      hairColor: hairColorController.text,
      skinColor: skinColorController.text,
      fashionStyle: fashionStyleController.text,
      distinguishingFeatures: distinguishingFeaturesController.text.split(', '),
      traits: traitsController.text.split(', '),
      hobbiesSkills: hobbiesSkillsController.text.split(', '),
      keyFamilyMembers: keyFamilyMembersController.text.split(', '),
      notableEvents: notableEventsController.text.split(', '),
      goals: goalsController.text.split(', '),
      internalConflicts: internalConflictsController.text.split(', '),
      externalConflicts: externalConflictsController.text.split(', '),
      coreValues: coreValuesController.text.split(', '),
    );
  }
}
