import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/editing/note_editing.dart';
import 'package:writing_app/screens/notes/models/character_note.dart';
import 'package:writing_app/screens/notes/widgets/dynamic_list_field.dart';
import 'package:writing_app/widgets/custom_text_field.dart';
import 'package:writing_app/widgets/large_text_field.dart';
import 'package:writing_app/widgets/minimal_text_field.dart';

class CharacterNoteEditing extends NoteEditing {
  CharacterNoteEditing(this.note) : super(note.imageUrl) {
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

    // Large text field
    otherPersonalityDetailsController =
        TextEditingController(text: note.otherPersonalityDetails ?? '');
  }
  final CharacterNote note;

  // Controllers for single-line text fields
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

  // Large text field
  late TextEditingController otherPersonalityDetailsController;

  @override
  Widget buildDetailsForm(GlobalKey<FormState> formKey, BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImageField(context),
            const SizedBox(height: 16),

            // General Information Section
            _buildSection(
              context,
              'General Information',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MinimalTextField(
                    controller: nameController,
                    hintText: 'Name...',
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  CustomTextField(controller: roleController, label: 'Role'),
                  CustomTextField(
                    controller: genderController,
                    label: 'Gender',
                  ),
                  CustomTextField(
                    controller: ageController,
                    label: 'Age',
                    isNumber: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Physical Appearance Section
            _buildSection(
              context,
              'Physical Appearance',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: eyeColorController,
                    label: 'Eye Color',
                  ),
                  CustomTextField(
                    controller: hairColorController,
                    label: 'Hair Color',
                  ),
                  CustomTextField(
                    controller: skinColorController,
                    label: 'Skin Color',
                  ),
                  CustomTextField(
                    controller: fashionStyleController,
                    label: 'Fashion Style',
                  ),
                  DynamicListField(
                    context: context,
                    label: 'Distinguishing Features',
                    list: distinguishingFeatures,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Personality Section
            _buildSection(
              context,
              'Personality',
              Column(
                children: [
                  DynamicListField(
                    context: context,
                    label: 'Traits',
                    list: traits,
                  ),
                  DynamicListField(
                    context: context,
                    label: 'Hobbies and Skills',
                    list: hobbiesSkills,
                  ),
                  LargeTextField(
                    controller: otherPersonalityDetailsController,
                    label: 'Other Personality Details',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // History Section
            _buildSection(
              context,
              'History',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DynamicListField(
                    context: context,
                    label: 'Key Family Members',
                    list: keyFamilyMembers,
                  ),
                  DynamicListField(
                    context: context,
                    label: 'Notable Events',
                    list: notableEvents,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Character Growth Section
            _buildSection(
              context,
              'Character Growth',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DynamicListField(
                    context: context,
                    label: 'Goals',
                    list: goals,
                  ),
                  DynamicListField(
                    context: context,
                    label: 'Internal Conflicts',
                    list: internalConflicts,
                  ),
                  DynamicListField(
                    context: context,
                    label: 'External Conflicts',
                    list: externalConflicts,
                  ),
                  DynamicListField(
                    context: context,
                    label: 'Core Values',
                    list: coreValues,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(title, context),
          const SizedBox(height: 8),
          child, // Content of the section
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }

  @override
  CharacterNote buildUpdatedNote() {
    return CharacterNote(
      id: note.id,
      createdAt: note.createdAt,
      imageUrl: imagePath ?? 'assets/images/placeholder.png',
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
      otherPersonalityDetails: otherPersonalityDetailsController.text,
      position: note.position,
    );
  }
}
