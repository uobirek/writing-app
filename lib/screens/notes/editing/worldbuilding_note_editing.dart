import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/editing/note_editing.dart';
import 'package:writing_app/screens/notes/models/worldbuilding_note.dart';
import 'package:writing_app/screens/notes/widgets/custom_text_field.dart';

class WorldbuildingNoteEditing extends NoteEditing {
  final WorldbuildingNote note;
  late TextEditingController placeNameController;
  late TextEditingController geographyController;
  late TextEditingController cultureController;
  late List<String> pointsOfInterest; // Dynamic list

  WorldbuildingNoteEditing(this.note) : super(note.image) {
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
          _buildDynamicListField(
              context, 'Points of Interest', pointsOfInterest),
        ],
      ),
    );
  }

  Widget _buildDynamicListField(
      BuildContext context, String label, List<String> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: list[index],
                    decoration: const InputDecoration(hintText: 'Enter item'),
                    onChanged: (value) {
                      list[index] = value; // Update list item
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    list.removeAt(index); // Remove item
                    (context as Element).markNeedsBuild(); // Rebuild UI
                  },
                ),
              ],
            );
          },
        ),
        TextButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Add Item'),
          onPressed: () {
            list.add(''); // Add an empty item
            (context as Element).markNeedsBuild(); // Rebuild UI
          },
        ),
      ],
    );
  }

  @override
  WorldbuildingNote buildUpdatedNote() {
    return WorldbuildingNote(
      id: note.id,
      title: placeNameController.text,
      createdAt: note.createdAt,
      image: imageController.text.isEmpty
          ? note.image ?? 'assets/images/placeholder.png'
          : imageController.text,
      placeName: placeNameController.text,
      geography: geographyController.text,
      culture: cultureController.text,
      pointsOfInterest: pointsOfInterest
          .where((item) => item.isNotEmpty)
          .toList(), // Filter out empty items
    );
  }
}
