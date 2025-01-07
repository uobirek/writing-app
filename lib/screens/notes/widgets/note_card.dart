
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/screens/notes/models/character_note.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/widgets/dynamic_image.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onDelete; // Callback for delete

  const NoteCard({
    super.key,
    required this.note,
    required this.onDelete, // Accept delete callback
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey inkWellKey = GlobalKey();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 1,
      child: SizedBox(
        width: 360,
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              if (note.image != null)
                DynamicImageWidget(
                  imagePath: note.image!,
                  width: 140,
                  height: 140,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              NoteInfo(note: note),
              InkWell(
                onTap: () => _showOptionsDialog(context),
                key: inkWellKey,
                child: const Icon(Icons.more_horiz),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(0, 0, 0, 0),
      items: [
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: [
              Icon(Icons.edit, color: Theme.of(context).colorScheme.secondary),
              const SizedBox(width: 8),
              const Text("Edit"),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: [
              Icon(Icons.preview,
                  color: Theme.of(context).colorScheme.secondary),
              const SizedBox(width: 8),
              const Text("Preview"),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Row(
            children: [
              Icon(Icons.delete,
                  color: Theme.of(context).colorScheme.secondary),
              const SizedBox(width: 8),
              const Text("Delete"),
            ],
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value == 0) {
        // Handle "Edit" action
        context.go('/note/${note.id}/editing');
      } else if (value == 1) {
        // Handle "Preview" action
        context.go('/note/${note.id}');
      } else if (value == 2) {
        // Handle "Delete" action
        _showDeleteConfirmationDialog(context);
      }
    });
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this note?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                onDelete(); // Trigger the delete callback
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}

class NoteInfo extends StatelessWidget {
  const NoteInfo({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          DecoratedBox(
              decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .secondary
                      .withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                child: Text(note.category,
                    style: Theme.of(context).textTheme.labelSmall),
              )),
          Text(
            note.title,
            style: Theme.of(context).textTheme.labelLarge,
            softWrap: true,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            (note is CharacterNote)
                ? (note as CharacterNote)
                        .traits
                        ?.map((trait) => trait)
                        .join('/') ??
                    ''
                : '',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ],
      ),
    );
  }
}
