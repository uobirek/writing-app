import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:writing_app/data/notes_data.dart';
import 'package:writing_app/screens/notes/create_a_blank_note.dart';
import 'package:writing_app/screens/notes/editing/note_editing.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/models/simple_note.dart';
import 'package:writing_app/screens/notes/models/character_note.dart';
import 'package:writing_app/screens/notes/models/worldbuilding_note.dart';
import 'package:writing_app/screens/notes/note_details/note_details.dart';
import 'package:writing_app/screens/notes/note_details/worldbuilding_note_details.dart';
import 'package:writing_app/screens/notes/note_details/character_note_details.dart';
import 'package:writing_app/screens/notes/note_details/simple_note_details.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  late NoteEditing noteEditing;
  final _formKey = GlobalKey<FormState>();
  String _selectedNoteType = 'SimpleNote';

  @override
  void initState() {
    super.initState();
    _initializeNoteDetailsUI();
  }

  void _initializeNoteDetailsUI() {
    final blankNote = createBlankNote(_selectedNoteType);
    noteEditing = blankNote.getNoteEditing();
  }

  void _onNoteTypeChanged(String? newType) {
    if (newType != null && newType != _selectedNoteType) {
      setState(() {
        _selectedNoteType = newType;
        _initializeNoteDetailsUI();
      });
    }
  }

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      final newNote = noteEditing.buildUpdatedNote();
      notes.add(newNote);
      context.go('/notes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SidebarLayout(
      activeRoute: '/notes',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add New Note'),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveNote,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedNoteType,
                items: const [
                  DropdownMenuItem(
                      value: 'SimpleNote', child: Text('Simple Note')),
                  DropdownMenuItem(
                      value: 'CharacterNote', child: Text('Character Note')),
                  DropdownMenuItem(
                      value: 'WorldbuildingNote',
                      child: Text('Worldbuilding Note')),
                ],
                onChanged: _onNoteTypeChanged,
                decoration:
                    const InputDecoration(labelText: 'Select Note Type'),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: noteEditing.buildDetailsForm(_formKey, context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
