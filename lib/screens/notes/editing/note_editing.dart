import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/models/note.dart';

abstract class NoteEditing {
  Widget buildDetailsForm(GlobalKey<FormState> formKey, BuildContext context);
  Note buildUpdatedNote();
}
