import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/note.dart';
import 'package:writing_app/screens/notes/notecard.dart';
import 'package:writing_app/screens/notes/notesdata.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  String currentCategory = 'Show All';

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                padding:
                    const EdgeInsets.all(20), // Padding inside the grey square
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
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
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12), // Rounded corners for tabs
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  // Function to build the list of notes with custom drag-and-drop
  Widget buildNotesList() {
    final filteredNotes = notes.where((note) {
      return currentCategory == 'Show All' || note.category == currentCategory;
    }).toList();

    return SingleChildScrollView(
      child: Wrap(
        spacing: 10, // Spacing between the notes
        runSpacing: 10,
        children: filteredNotes.map((note) {
          return Draggable<String>(
            data: note.id, // Przeciąganie danych z identyfikatorem notatki
            feedback: Material(
              color: Colors.transparent,
              child: MouseRegion(
                onEnter: (_) {
                  // Zmiana kursora na "grabbing" podczas przeciągania
                  SystemMouseCursors.grabbing;
                },
                onExit: (_) {
                  // Przywrócenie domyślnego kursora
                  SystemMouseCursors.basic;
                },
                child: _buildDraggedNote(
                    note), // Pokazuje element podczas przeciągania
              ),
            ),
            childWhenDragging:
                Container(), // Co widzisz, gdy element jest przeciągany
            child: DragTarget<String>(
              onAccept: (draggedNoteId) {
                // Zaktualizuj dane po przeniesieniu notatki
                setState(() {
                  final draggedNote =
                      notes.firstWhere((note) => note.id == draggedNoteId);
                  // Logika, jak chcesz zmienić kolejność notatek
                  notes.remove(draggedNote);
                  notes.insert(filteredNotes.indexOf(note), draggedNote);
                });
              },
              builder: (context, candidateData, rejectedData) {
                // Większy obszar dla DragTarget, aby łatwiej było upuścić element
                return MouseRegion(
                  onEnter: (_) {
                    // Zmiana kursora na "grab" podczas przeciągania
                    SystemMouseCursors.grab;
                  },
                  child: Material(
                    elevation: candidateData.isNotEmpty
                        ? 10
                        : 3, // Zwiększony cień, gdy element jest w obrębie docelowym
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    child: NoteCard(
                        note: note), // Notatka, która jest w miejscu docelowym
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  // Function to build the normal NoteCard
  Widget _buildNoteCard(Note note) {
    return NoteCard(note: note);
  }

  // Function to build the dragged NoteCard with shadow effect
  Widget _buildDraggedNote(Note note) {
    return Material(
      elevation: 10, // Bigger shadow while dragging
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: NoteCard(note: note),
    );
  }
}
