import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/data/notes_data.dart';
import 'package:writing_app/screens/notes/models/character_note.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/models/worldbuilding_note.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class EditNoteScreen extends StatefulWidget {
  final Note note;

  const EditNoteScreen({super.key, required this.note});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late String selectedNoteType;
  final _formKey = GlobalKey<FormState>();

  // Common fields
  late TextEditingController imageController;

  // CharacterNote-specific fields
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

  // WorldbuildingNote-specific fields
  late TextEditingController placeNameController;
  late TextEditingController geographyController;
  late TextEditingController cultureController;
  late TextEditingController pointsOfInterestController;

  @override
  void initState() {
    super.initState();

    // Determine the note type
    selectedNoteType =
        widget.note is CharacterNote ? "CharacterNote" : "WorldbuildingNote";

    // Initialize controllers with note data
    imageController = TextEditingController(text: widget.note.image);

    if (widget.note is CharacterNote) {
      final characterNote = widget.note as CharacterNote;
      nameController = TextEditingController(text: characterNote.name);
      roleController = TextEditingController(text: characterNote.role);
      genderController = TextEditingController(text: characterNote.gender);
      ageController =
          TextEditingController(text: characterNote.age.toString() ?? '');
      eyeColorController =
          TextEditingController(text: characterNote.eyeColor ?? '');
      hairColorController =
          TextEditingController(text: characterNote.hairColor ?? '');
      skinColorController =
          TextEditingController(text: characterNote.skinColor ?? '');
      fashionStyleController =
          TextEditingController(text: characterNote.fashionStyle ?? '');
      distinguishingFeaturesController = TextEditingController(
          text: characterNote.distinguishingFeatures.join(', ') ?? '');
      traitsController =
          TextEditingController(text: characterNote.traits.join(', '));
      hobbiesSkillsController =
          TextEditingController(text: characterNote.hobbiesSkills.join(', '));
      keyFamilyMembersController = TextEditingController(
          text: characterNote.keyFamilyMembers.join(', ') ?? '');
      notableEventsController =
          TextEditingController(text: characterNote.notableEvents.join(', '));
      goalsController =
          TextEditingController(text: characterNote.goals.join(', '));
      internalConflictsController = TextEditingController(
          text: characterNote.internalConflicts.join(', '));
      externalConflictsController = TextEditingController(
          text: characterNote.externalConflicts.join(', '));
      coreValuesController =
          TextEditingController(text: characterNote.coreValues.join(', '));
    } else if (widget.note is WorldbuildingNote) {
      final worldbuildingNote = widget.note as WorldbuildingNote;
      placeNameController =
          TextEditingController(text: worldbuildingNote.placeName);
      geographyController =
          TextEditingController(text: worldbuildingNote.geography);
      cultureController =
          TextEditingController(text: worldbuildingNote.culture);
      pointsOfInterestController = TextEditingController(
          text: worldbuildingNote.pointsOfInterest.join(', '));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SidebarLayout(
        activeRoute: '/notes',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 30,
                  spreadRadius: 6,
                )
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dropdown to display the note type (read-only)
                    DropdownButtonFormField<String>(
                      value: selectedNoteType,
                      decoration: const InputDecoration(labelText: "Note Type"),
                      items: const [
                        DropdownMenuItem(
                          value: "CharacterNote",
                          child: Text("Character Note"),
                        ),
                        DropdownMenuItem(
                          value: "WorldbuildingNote",
                          child: Text("Worldbuilding Note"),
                        ),
                      ],
                      onChanged: null, // Make it read-only
                    ),
                    const SizedBox(height: 16),

                    // Common fields

                    TextFormField(
                      controller: imageController,
                      decoration: const InputDecoration(labelText: "Image URL"),
                    ),
                    const SizedBox(height: 16),

                    // Dynamic fields based on the selected note type
                    if (selectedNoteType == "CharacterNote") ...[
                      _buildCharacterNoteFields(),
                    ] else if (selectedNoteType == "WorldbuildingNote") ...[
                      _buildWorldbuildingNoteFields(),
                    ],

                    const SizedBox(height: 16),

                    // Submit button
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.resolveWith<Color?>(
                          (Set<WidgetState> states) {
                            return Theme.of(context).colorScheme.secondary;
                          },
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final updatedNote = selectedNoteType ==
                                  "CharacterNote"
                              ? CharacterNote(
                                  id: widget.note.id,
                                  createdAt: widget.note.createdAt,
                                  image: imageController.text,
                                  name: nameController.text,
                                  role: roleController.text,
                                  gender: genderController.text,
                                  age: int.tryParse(ageController.text) ?? 0,
                                  eyeColor: eyeColorController.text,
                                  hairColor: hairColorController.text,
                                  skinColor: skinColorController.text,
                                  fashionStyle: fashionStyleController.text,
                                  distinguishingFeatures:
                                      distinguishingFeaturesController.text
                                          .split(',')
                                          .map((f) => f.trim())
                                          .toList(),
                                  traits: traitsController.text
                                      .split(',')
                                      .map((t) => t.trim())
                                      .toList(),
                                  hobbiesSkills: hobbiesSkillsController.text
                                      .split(',')
                                      .map((h) => h.trim())
                                      .toList(),
                                  keyFamilyMembers: keyFamilyMembersController
                                      .text
                                      .split(',')
                                      .map((f) => f.trim())
                                      .toList(),
                                  notableEvents: notableEventsController.text
                                      .split(',')
                                      .map((e) => e.trim())
                                      .toList(),
                                  goals: goalsController.text
                                      .split(',')
                                      .map((g) => g.trim())
                                      .toList(),
                                  internalConflicts: internalConflictsController
                                      .text
                                      .split(',')
                                      .map((c) => c.trim())
                                      .toList(),
                                  externalConflicts: externalConflictsController
                                      .text
                                      .split(',')
                                      .map((c) => c.trim())
                                      .toList(),
                                  coreValues: coreValuesController.text
                                      .split(',')
                                      .map((v) => v.trim())
                                      .toList(),
                                )
                              : WorldbuildingNote(
                                  id: widget.note.id,
                                  title: widget.note.title,
                                  createdAt: widget.note.createdAt,
                                  image: imageController.text,
                                  placeName: placeNameController.text,
                                  geography: geographyController.text,
                                  culture: cultureController.text,
                                  pointsOfInterest: pointsOfInterestController
                                      .text
                                      .split(',')
                                      .map((poi) => poi.trim())
                                      .toList(),
                                );
                          notes.remove(widget.note);
                          notes.add(updatedNote);
                          context.go('/notes');
                        }
                      },
                      child: const Text("Save Changes"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildCharacterNoteFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.0,
      children: [
        _buildTextField(nameController, "Name"),
        _buildTextField(roleController, "Role"),
        _buildTextField(genderController, "Gender"),
        _buildTextField(ageController, "Age", isNumber: true),
        _buildTextField(eyeColorController, "Eye Color"),
        _buildTextField(hairColorController, "Hair Color"),
        _buildTextField(skinColorController, "Skin Color"),
        _buildTextField(fashionStyleController, "Fashion Style"),
        _buildTextField(distinguishingFeaturesController,
            "Distinguishing Features (comma-separated)"),
        DynamicListInput(
            controller: traitsController, label: "Personality Traits"),
        _buildTextField(
            hobbiesSkillsController, "Hobbies and Skills (comma-separated)"),
        _buildTextField(
            keyFamilyMembersController, "Key Family Members (comma-separated)"),
        _buildTextField(
            notableEventsController, "Notable Events (comma-separated)"),
        _buildTextField(goalsController, "Goals (comma-separated)"),
        _buildTextField(internalConflictsController,
            "Internal Conflicts (comma-separated)"),
        _buildTextField(externalConflictsController,
            "External Conflicts (comma-separated)"),
        _buildTextField(coreValuesController, "Core Values (comma-separated)"),
      ],
    );
  }

  Widget _buildWorldbuildingNoteFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(placeNameController, "Place Name"),
        _buildTextField(geographyController, "Geography"),
        _buildTextField(cultureController, "Culture"),
        _buildTextField(
            pointsOfInterestController, "Points of Interest (comma-separated)"),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary))),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      ),
    );
  }
}

class DynamicListInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const DynamicListInput(
      {super.key, required this.controller, required this.label});

  @override
  _DynamicListInputState createState() => _DynamicListInputState();
}

class _DynamicListInputState extends State<DynamicListInput> {
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _controllers.add(TextEditingController()); // Initial empty field
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addField() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  void _removeField(int index) {
    setState(() {
      _controllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        ..._controllers.map((controller) {
          int index = _controllers.indexOf(controller);
          return Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "Enter ${widget.label.toLowerCase()}",
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (_controllers.length > 1) {
                    _removeField(index);
                  }
                },
              ),
            ],
          );
        }),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _addField,
        ),
      ],
    );
  }
}
