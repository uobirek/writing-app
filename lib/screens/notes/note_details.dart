import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class NoteDetailsScreen extends StatelessWidget {
  final Note note;

  const NoteDetailsScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return SidebarLayout(
      activeRoute: "/notes",
      child: Scaffold(
        appBar: AppBar(
          title: Text(note.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Note Image
                if (note.image!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      note.image ?? '',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 20),

                // Note Details
                note.getNoteDetails().buildDetailsScreen(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
