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
        width: 360,
        height: 180,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
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

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        DecoratedBox(
                            decoration: BoxDecoration(
                                color: AppColors.accentcolour2
                                    .withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 8.0),
                              child: Text(
                                note.category,
                                style: AppTextStyles.body,
                              ),
                            )),
                        Text(
                          note.title,
                          style: AppTextStyles.bolded,
                          softWrap: true,
                          maxLines: 3, // Allow two lines
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_horiz)
                ])),
      ),
    );
  }
}
