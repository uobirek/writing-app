import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/features/notes/cubit/note_cubit.dart';
import 'package:writing_app/features/notes/models/character_note.dart';
import 'package:writing_app/features/notes/models/note.dart';
import 'package:writing_app/features/notes/widgets/dynamic_image.dart';
import 'package:writing_app/features/projects/cubit/project_cubit.dart';
import 'package:writing_app/l10n/app_localizations.dart';

class NoteCard extends StatelessWidget {
  // Callback for delete

  const NoteCard({
    super.key,
    required this.note,
    required this.onDelete, // Accept delete callback
  });
  final Note note;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 1,
      child: SizedBox(
        width: 360,
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: _isMobile() ? 9 : 12,
            children: [
              if (note.imageUrl != null)
                DynamicImageWidget(
                  imagePath: note.imageUrl,
                  width: _isMobile() ? 130 : 140,
                  height: _isMobile() ? 130 : 140,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              NoteInfo(note: note),
              _noteMenu(context),
            ],
          ),
        ),
      ),
    );
  }

  bool _isMobile() {
    return Platform.isAndroid || Platform.isIOS;
  }

  Widget _noteMenu(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: [
              Icon(Icons.edit, color: Theme.of(context).colorScheme.secondary),
              const SizedBox(width: 8),
              Text(localizations!.edit),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: [
              Icon(
                Icons.preview,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(width: 8),
              Text(localizations.preview),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Row(
            children: [
              Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(width: 8),
              Text(localizations.delete),
            ],
          ),
        ),
      ],
      elevation: 8,
      initialValue: 0,
      onSelected: (value) {
        if (value == 0) {
          // Handle 'Edit' action

          context.go('/note/${note.id}/editing');
        } else if (value == 1) {
          // Handle 'Preview' action
          context.go('/note/${note.id}');
        } else if (value == 2) {
          // Handle 'Delete' action
          _showDeleteConfirmationDialog(context);
        }
      },
      offset: const Offset(0, -90),
      child: const Icon(Icons.more_horiz),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(localizations!.confirmDelete),
          content: Text(localizations.areYouSureDeleteNote),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(localizations.cancel),
            ),
            TextButton(
              onPressed: () {
                final projectCubit = context.read<ProjectCubit>();
                final project = projectCubit.selectedProject;
                context.read<NoteCubit>().deleteNote(
                      note.id,
                      project!.id,
                    ); // Trigger the delete action
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                localizations.delete,
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
              color: note.category == 'Worldbuilding'
                  ? Theme.of(context)
                      .colorScheme
                      .secondary
                      .withValues(alpha: 0.4)
                  : Theme.of(context)
                      .colorScheme
                      .tertiary
                      .withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              child: Text(
                _getLocalizedCategory(context, note.category),
                style: note.category == 'Worldbuilding'
                    ? Theme.of(context).textTheme.labelSmall
                    : Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
              ),
            ),
          ),
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
                        .join(' | ') ??
                    ''
                : '',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }

  bool _isMobile() {
    return Platform.isAndroid || Platform.isIOS;
  }
}

String _getLocalizedCategory(BuildContext context, String category) {
  final localizations = AppLocalizations.of(context);

  switch (category) {
    case 'Worldbuilding':
      return localizations!.worldbuilding;
    case 'Characters':
      return localizations!.characters;
    case 'Outline':
      return localizations!.outline;
    default:
      return localizations!.showAll; // Fallback for unknown categories
  }
}
