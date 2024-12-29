import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/models/character_note.dart';
import 'package:writing_app/screens/notes/models/worldbuilding_note.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  String selectedNoteType = "CharacterNote"; // Default type
  final _formKey = GlobalKey<FormState>();

  // Common fields
  final TextEditingController titleController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  // CharacterNote-specific fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController eyeColorController = TextEditingController();
  final TextEditingController hairColorController = TextEditingController();
  final TextEditingController skinColorController = TextEditingController();
  final TextEditingController fashionStyleController = TextEditingController();
  final TextEditingController distinguishingFeaturesController =
      TextEditingController();
  final TextEditingController traitsController = TextEditingController();
  final TextEditingController hobbiesSkillsController =
      TextEditingController(); // New Field
  final TextEditingController keyFamilyMembersController =
      TextEditingController();
  final TextEditingController notableEventsController = TextEditingController();
  final TextEditingController goalsController = TextEditingController();
  final TextEditingController internalConflictsController =
      TextEditingController();
  final TextEditingController externalConflictsController =
      TextEditingController();
  final TextEditingController coreValuesController = TextEditingController();

  // WorldbuildingNote-specific fields
  final TextEditingController placeNameController = TextEditingController();
  final TextEditingController geographyController = TextEditingController();
  final TextEditingController cultureController = TextEditingController();
  final TextEditingController pointsOfInterestController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropdown to select the type of note
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
                  onChanged: (value) {
                    setState(() {
                      selectedNoteType = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Common fields
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Title is required";
                    }
                    return null;
                  },
                ),
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle form submission
                      final newNote = selectedNoteType == "CharacterNote"
                          ? CharacterNote(
                              id: DateTime.now().toString(),
                              createdAt: DateTime.now(),
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
                              keyFamilyMembers: keyFamilyMembersController.text
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
                              id: DateTime.now().toString(),
                              title: titleController.text,
                              createdAt: DateTime.now(),
                              image: imageController.text,
                              placeName: placeNameController.text,
                              geography: geographyController.text,
                              culture: cultureController.text,
                              pointsOfInterest: pointsOfInterestController.text
                                  .split(',')
                                  .map((poi) => poi.trim())
                                  .toList(),
                            );

                      print(newNote.toJson()); // Replace with your logic
                      Navigator.pop(context); // Go back after saving
                    }
                  },
                  child: const Text("Save Note"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterNoteFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        _buildTextField(
            traitsController, "Personality Traits (comma-separated)"),
        _buildTextField(hobbiesSkillsController,
            "Hobbies and Skills (comma-separated)"), // New Field
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
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
    );
  }
}
