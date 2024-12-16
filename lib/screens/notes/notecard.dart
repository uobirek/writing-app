import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/note.dart';
import 'package:writing_app/utils/theme.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.verylight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      child: SizedBox(
        width: 350,
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              if (note.image != null)
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(
                    note.image ?? "",
                    width: 140,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                          maxWidth: 140), // Max width for title
                      child: Text(
                        note.title,
                        style: AppTextStyles.bolded,
                        maxLines: 2, // Allow two lines
                        overflow: TextOverflow.ellipsis, // Prevent overflow
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
