import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/notecard.dart';
import 'package:writing_app/screens/notes/notesdata.dart';
import 'package:writing_app/utils/theme.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  String currentCategory = 'Show All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.verylight,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            // Tabs outside the grey square, on top of it
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    _buildTab('Show All'),
                    _buildTab('Worldbuilding'),
                    _buildTab('Characters'),
                    _buildTab('Outline'),
                  ],
                ),
              ),
            ),
            // The grey square takes up the remaining space, excluding top and bottom margins

            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.all(
                      20), // Padding inside the grey square
                  decoration: BoxDecoration(
                    color: AppColors
                        .bigsquaregrey, // Background color of the square
                    borderRadius: BorderRadius.circular(
                        12), // Rounded corners for the square
                  ),
                  child:
                      buildNotesList(), // Display note cards inside the grey square
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build a tab with rounded corners
  Widget _buildTab(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentCategory = text;
        });
      },
      child: Container(
        height: 30,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: currentCategory == text
              ? AppColors.bigsquaregrey
              : AppColors.verylight,
          borderRadius: BorderRadius.circular(12), // Rounded corners for tabs
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: currentCategory == text ? AppColors.text : AppColors.text,
          ),
        ),
      ),
    );
  }

  // Function to build the list of notes
  Widget buildNotesList() {
    final filteredNotes = notes.where((note) {
      return currentCategory == 'Show All' || note.category == currentCategory;
    }).toList();

    return SingleChildScrollView(
      child: Wrap(
        spacing: 10, // Spacing between the notes
        runSpacing: 10,
        children: filteredNotes.map((note) {
          return NoteCard(note: note);
        }).toList(),
      ),
    );
  }
}
