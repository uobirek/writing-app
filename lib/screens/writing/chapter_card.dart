import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/screens/writing/models/chapter.dart';

class ChapterCard extends StatelessWidget {
  final Chapter chapter;
  const ChapterCard({
    super.key,
    required this.chapter,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      child: SizedBox(
          width: 500,
          height: 90,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              spacing: 22,
              children: [
                const Icon(Icons.drag_indicator),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(chapter.title ?? '',
                          style: Theme.of(context).textTheme.labelLarge),
                      Text(
                        chapter.content ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                InkWell(
                    onTap: () => {context.go('/chapter/${chapter.id}')},
                    child: Icon(
                      Icons.create_outlined,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
              ],
            ),
          )),
    );
  }
}
