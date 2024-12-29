import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/data/notes_data.dart';
import 'package:writing_app/screens/notes/models/character_note.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/models/worldbuilding_note.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';
import 'package:writing_app/screens/notes/widgets/custom_text_field.dart';

class FieldConfig {
  final TextEditingController controller;
  final String label;
  final bool isNumber;

  FieldConfig({
    required this.controller,
    required this.label,
    this.isNumber = false,
  });
}

class EditNoteScreen extends StatefulWidget {
  final Note note;

  const EditNoteScreen({super.key, required this.note});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  late String selectedNoteType;
  late List<FieldConfig> fields = [];

  @override
  void initState() {
    super.initState();

    // Determine the note type
    selectedNoteType =
        widget.note is CharacterNote ? "CharacterNote" : "WorldbuildingNote";

    // Initialize the fields dynamically
    _initializeFields();
  }

  void _initializeFields() {
    fields.add(FieldConfig(
      controller: TextEditingController(text: widget.note.image),
      label: "Image URL",
    ));

    if (widget.note is CharacterNote) {
      final characterNote = widget.note as CharacterNote;

      fields.addAll([
        FieldConfig(
            controller: TextEditingController(text: characterNote.name),
            label: "Name"),
        FieldConfig(
            controller: TextEditingController(text: characterNote.role),
            label: "Role"),
        FieldConfig(
            controller: TextEditingController(text: characterNote.gender),
            label: "Gender"),
        FieldConfig(
          controller: TextEditingController(text: characterNote.age.toString()),
          label: "Age",
          isNumber: true,
        ),
        FieldConfig(
            controller: TextEditingController(text: characterNote.eyeColor),
            label: "Eye Color"),
        FieldConfig(
            controller: TextEditingController(text: characterNote.hairColor),
            label: "Hair Color"),
        FieldConfig(
            controller: TextEditingController(text: characterNote.skinColor),
            label: "Skin Color"),
        FieldConfig(
            controller: TextEditingController(text: characterNote.fashionStyle),
            label: "Fashion Style"),
        FieldConfig(
          controller: TextEditingController(
              text: characterNote.distinguishingFeatures.join(', ')),
          label: "Distinguishing Features (comma-separated)",
        ),
        FieldConfig(
          controller:
              TextEditingController(text: characterNote.traits.join(', ')),
          label: "Traits (comma-separated)",
        ),
        FieldConfig(
          controller: TextEditingController(
              text: characterNote.hobbiesSkills.join(', ')),
          label: "Hobbies and Skills (comma-separated)",
        ),
        FieldConfig(
          controller: TextEditingController(
              text: characterNote.keyFamilyMembers.join(', ')),
          label: "Key Family Members (comma-separated)",
        ),
        FieldConfig(
          controller: TextEditingController(
              text: characterNote.notableEvents.join(', ')),
          label: "Notable Events (comma-separated)",
        ),
        FieldConfig(
          controller:
              TextEditingController(text: characterNote.goals.join(', ')),
          label: "Goals (comma-separated)",
        ),
        FieldConfig(
          controller: TextEditingController(
              text: characterNote.internalConflicts.join(', ')),
          label: "Internal Conflicts (comma-separated)",
        ),
        FieldConfig(
          controller: TextEditingController(
              text: characterNote.externalConflicts.join(', ')),
          label: "External Conflicts (comma-separated)",
        ),
        FieldConfig(
          controller:
              TextEditingController(text: characterNote.coreValues.join(', ')),
          label: "Core Values (comma-separated)",
        ),
      ]);
    } else if (widget.note is WorldbuildingNote) {
      final worldbuildingNote = widget.note as WorldbuildingNote;

      fields.addAll([
        FieldConfig(
            controller:
                TextEditingController(text: worldbuildingNote.placeName),
            label: "Place Name"),
        FieldConfig(
            controller:
                TextEditingController(text: worldbuildingNote.geography),
            label: "Geography"),
        FieldConfig(
            controller: TextEditingController(text: worldbuildingNote.culture),
            label: "Culture"),
        FieldConfig(
          controller: TextEditingController(
              text: worldbuildingNote.pointsOfInterest.join(', ')),
          label: "Points of Interest (comma-separated)",
        ),
      ]);
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
                    onChanged: null, // Read-only
                  ),
                  const SizedBox(height: 16),

                  // Dynamic fields
                  ...fields.map((field) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomTextField(
                        controller: field.controller,
                        label: field.label,
                        isNumber: field.isNumber,
                      ),
                    );
                  }),

                  const SizedBox(height: 16),

                  // Submit button
                  ElevatedButton(
                    onPressed: _saveNote,
                    child: const Text("Save Changes"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      if (selectedNoteType == "CharacterNote") {
        final updatedNote = CharacterNote(
          id: widget.note.id,
          createdAt: widget.note.createdAt,
          image: fields[0].controller.text,
          name: fields[1].controller.text,
          role: fields[2].controller.text,
          gender: fields[3].controller.text,
          age: int.tryParse(fields[4].controller.text) ?? 0,
          eyeColor: fields[5].controller.text,
          hairColor: fields[6].controller.text,
          skinColor: fields[7].controller.text,
          fashionStyle: fields[8].controller.text,
          distinguishingFeatures: fields[9]
              .controller
              .text
              .split(',')
              .map((f) => f.trim())
              .toList(),
          traits: fields[10]
              .controller
              .text
              .split(',')
              .map((t) => t.trim())
              .toList(),
          hobbiesSkills: fields[11]
              .controller
              .text
              .split(',')
              .map((h) => h.trim())
              .toList(),
          keyFamilyMembers: fields[12]
              .controller
              .text
              .split(',')
              .map((f) => f.trim())
              .toList(),
          notableEvents: fields[13]
              .controller
              .text
              .split(',')
              .map((e) => e.trim())
              .toList(),
          goals: fields[14]
              .controller
              .text
              .split(',')
              .map((g) => g.trim())
              .toList(),
          internalConflicts: fields[15]
              .controller
              .text
              .split(',')
              .map((c) => c.trim())
              .toList(),
          externalConflicts: fields[16]
              .controller
              .text
              .split(',')
              .map((c) => c.trim())
              .toList(),
          coreValues: fields[17]
              .controller
              .text
              .split(',')
              .map((v) => v.trim())
              .toList(),
        );

        notes.remove(widget.note);
        notes.add(updatedNote);
      } else if (selectedNoteType == "WorldbuildingNote") {
        final updatedNote = WorldbuildingNote(
          id: widget.note.id,
          createdAt: widget.note.createdAt,
          image: fields[0].controller.text,
          placeName: fields[1].controller.text,
          geography: fields[2].controller.text,
          culture: fields[3].controller.text,
          pointsOfInterest: fields[4]
              .controller
              .text
              .split(',')
              .map((poi) => poi.trim())
              .toList(),
          title: '',
        );

        notes.remove(widget.note);
        notes.add(updatedNote);
      }

      context.go('/notes');
    }
  }
}
