import 'dart:io';

import 'package:flutter/material.dart';
import 'package:writing_app/features/notes/models/character_note.dart';
import 'package:writing_app/features/notes/screens/editing/note_editing.dart';
import 'package:writing_app/features/notes/widgets/dynamic_list_field.dart';
import 'package:writing_app/l10n/app_localizations.dart';
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

    distinguishingFeatures = note.distinguishingFeatures ?? [];
    traits = note.traits ?? [];
    hobbiesSkills = note.hobbiesSkills ?? [];
    keyFamilyMembers = note.keyFamilyMembers ?? [];
    notableEvents = note.notableEvents ?? [];
    goals = note.goals ?? [];
    internalConflicts = note.internalConflicts ?? [];
    externalConflicts = note.externalConflicts ?? [];
    coreValues = note.coreValues ?? [];

    otherPersonalityDetailsController =
        TextEditingController(text: note.otherPersonalityDetails ?? '');
  }
  final CharacterNote note;

  late TextEditingController nameController;
  late TextEditingController roleController;
  late TextEditingController genderController;
  late TextEditingController ageController;
  late TextEditingController eyeColorController;
  late TextEditingController hairColorController;
  late TextEditingController skinColorController;
  late TextEditingController fashionStyleController;

  late List<String> distinguishingFeatures;
  late List<String> traits;
  late List<String> hobbiesSkills;
  late List<String> keyFamilyMembers;
  late List<String> notableEvents;
  late List<String> goals;
  late List<String> internalConflicts;
  late List<String> externalConflicts;
  late List<String> coreValues;

  late TextEditingController otherPersonalityDetailsController;

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
                  CustomTextField(
                    controller: roleController,
                    label: localizations!.role,
                  ),
                  CustomTextField(
                    controller: genderController,
                    label: localizations.gender,
                  ),
                  CustomTextField(
                    controller: ageController,
                    label: localizations.age,
                    isNumber: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              localizations.physicalAppearance,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: eyeColorController,
                    label: localizations.eyeColor,
                  ),
                  CustomTextField(
                    controller: hairColorController,
                    label: localizations.hairColor,
                  ),
                  CustomTextField(
                    controller: skinColorController,
                    label: localizations.skinColor,
                  ),
                  CustomTextField(
                    controller: fashionStyleController,
                    label: localizations.fashionStyle,
                  ),
                  DynamicListField(
                    context: context,
                    label: localizations.distinguishingFeatures,
                    list: distinguishingFeatures,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              localizations.personality,
              Column(
                children: [
                  DynamicListField(
                    context: context,
                    label: localizations.personalityTraits,
                    list: traits,
                  ),
                  DynamicListField(
                    context: context,
                    label: localizations.hobbiesAndSkills,
                    list: hobbiesSkills,
                  ),
                  LargeTextField(
                    controller: otherPersonalityDetailsController,
                    label: localizations.otherPersonalityDetails,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              localizations.history,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DynamicListField(
                    context: context,
                    label: localizations.keyFamilyMembers,
                    list: keyFamilyMembers,
                  ),
                  DynamicListField(
                    context: context,
                    label: localizations.notableEvents,
                    list: notableEvents,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              localizations.characterGrowth,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DynamicListField(
                    context: context,
                    label: localizations.goals,
                    list: goals,
                  ),
                  DynamicListField(
                    context: context,
                    label: localizations.internalConflicts,
                    list: internalConflicts,
                  ),
                  DynamicListField(
                    context: context,
                    label: localizations.externalConflicts,
                    list: externalConflicts,
                  ),
                  DynamicListField(
                    context: context,
                    label: localizations.coreValues,
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

  bool _isMobile() {
    return Platform.isAndroid || Platform.isIOS;
  }

  Widget _buildSection(BuildContext context, String title, Widget child) {
    return Container(
      margin: _isMobile()
          ? const EdgeInsets.symmetric(vertical: 8)
          : EdgeInsets.zero,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
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
          child,
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
      imageUrl: imagePath ?? 'assets/images/placeholder.jpg',
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
