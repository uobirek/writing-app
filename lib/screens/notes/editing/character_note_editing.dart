import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/editing/note_editing.dart';
import 'package:writing_app/screens/notes/models/character_note.dart';
import 'package:writing_app/screens/notes/widgets/custom_text_field.dart';
import 'package:writing_app/screens/notes/widgets/dynamic_list_field.dart';

class CharacterNoteEditing extends NoteEditing {
  final CharacterNote note;

  late TextEditingController nameController;
  late TextEditingController roleController;
  late TextEditingController genderController;
  late TextEditingController ageController;
  late TextEditingController eyeColorController;
  late TextEditingController hairColorController;
  late TextEditingController skinColorController;
  late TextEditingController fashionStyleController;

  // List fields
  late List<String> distinguishingFeatures;
  late List<String> traits;
  late List<String> hobbiesSkills;
  late List<String> keyFamilyMembers;
  late List<String> notableEvents;
  late List<String> goals;
  late List<String> internalConflicts;
  late List<String> externalConflicts;
  late List<String> coreValues;

  CharacterNoteEditing(this.note) : super(note.image) {
    nameController = TextEditingController(text: note.name);
    roleController = TextEditingController(text: note.role);
    genderController = TextEditingController(text: note.gender);
    ageController = TextEditingController(text: note.age.toString());
    eyeColorController = TextEditingController(text: note.eyeColor);
    hairColorController = TextEditingController(text: note.hairColor);
    skinColorController = TextEditingController(text: note.skinColor);
    fashionStyleController = TextEditingController(text: note.fashionStyle);

    // Initialize list-based fields
    distinguishingFeatures = note.distinguishingFeatures ?? [];
    traits = note.traits ?? [];
    hobbiesSkills = note.hobbiesSkills ?? [];
    keyFamilyMembers = note.keyFamilyMembers ?? [];
    notableEvents = note.notableEvents ?? [];
    goals = note.goals ?? [];
    internalConflicts = note.internalConflicts ?? [];
    externalConflicts = note.externalConflicts ?? [];
    coreValues = note.coreValues ?? [];
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

          // Regular text inputs for non-list fields
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

          // DynamicListField for list-based fields
          const SizedBox(height: 16),
          DynamicListField(
              context: context,
              label: 'Distinguishing Features',
              list: distinguishingFeatures),
          DynamicListField(context: context, label: 'Traits', list: traits),
          DynamicListField(
              context: context,
              label: 'Hobbies and Skills',
              list: hobbiesSkills),
          DynamicListField(
              context: context,
              label: 'Key Family Membersed)',
              list: keyFamilyMembers),
          DynamicListField(
              context: context, label: 'Notable Events', list: notableEvents),
          DynamicListField(context: context, label: 'Goals', list: goals),
          DynamicListField(
              context: context,
              label: 'Internal Conflicts',
              list: internalConflicts),
          DynamicListField(
              context: context,
              label: 'External Conflicts',
              list: externalConflicts),
          DynamicListField(
              context: context, label: 'Core Values', list: coreValues),
        ],
      ),
    );
  }

  @override
  CharacterNote buildUpdatedNote() {
    return CharacterNote(
        id: note.id,
        createdAt: note.createdAt,
        image: imagePath ?? 'assets/images/placeholder.png',
        name: nameController.text,
        role: roleController.text,
        gender: genderController.text,
        age: int.tryParse(ageController.text) ?? 0,
        eyeColor: eyeColorController.text,
        hairColor: hairColorController.text,
        skinColor: skinColorController.text,
        fashionStyle: fashionStyleController.text,
        distinguishingFeatures: distinguishingFeatures,
        traits: traits,
        hobbiesSkills: hobbiesSkills,
        keyFamilyMembers: keyFamilyMembers,
        notableEvents: notableEvents,
        goals: goals,
        internalConflicts: internalConflicts,
        externalConflicts: externalConflicts,
        coreValues: coreValues,
        position: note.position);
  }
}
