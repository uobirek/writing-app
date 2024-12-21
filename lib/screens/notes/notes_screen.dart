import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/widgets/note_card.dart';
import 'package:writing_app/data/notes_data.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  String currentCategory = 'Show All';

  @override
  Widget build(BuildContext context) {
    return SidebarLayout(
      activeRoute: '/notes',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
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
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.8),
                        Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: buildNotesList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text) {
    final bool isActive = currentCategory == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          currentCategory = text;
        });
      },
      child: Container(
        height: 40,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

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
                return Container(
                  decoration: BoxDecoration(
                    border: candidateData.isNotEmpty
                        ? Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withValues(alpha: 0.3),
                            width: 5)
                        : null,
                    borderRadius: BorderRadius.circular(23),
                  ),
                  child: NoteCard(note: note),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
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
