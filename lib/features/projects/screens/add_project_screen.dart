import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:writing_app/features/projects/cubit/project_cubit.dart';
import 'package:writing_app/features/projects/cubit/project_states.dart';
import 'package:writing_app/features/projects/models/project.dart';
import 'package:writing_app/l10n/app_localizations.dart';

class AddProjectScreen extends StatefulWidget {
  AddProjectScreen({super.key});
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations!.addNewProject),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<ProjectCubit, ProjectState>(
          listener: (context, state) {
            if (state is ProjectError) {
              _showErrorDialog(state.message, context);
            } else if (state is ProjectLoaded) {
              context.go('/projects');
            }
          },
          builder: (context, state) {
            return Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: localizations.projectTitle,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localizations.pleaseEnterProjectTitle;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: localizations.pleaseEnterProjectTitle,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localizations.pleaseEnterDescription;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      if (_imageFile == null)
                        Text(localizations.noImageSelected)
                      else
                        Image.file(_imageFile!, width: 100, height: 100),
                      IconButton(
                        icon: const Icon(Icons.photo_camera),
                        onPressed: _pickImage,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _addProject(context),
                    child: state is ProjectUpdating
                        ? const CircularProgressIndicator()
                        : Text(localizations.addNewProject),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _addProject(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      _showErrorDialog(localizations!.pleaseFillInAllFields, context);
      return;
    }

    final newProject = Project(
      id: '',
      title: _titleController.text,
      description: _descriptionController.text,
    );

    BlocProvider.of<ProjectCubit>(context).addProject(
      newProject,
      widget.userId,
      _imageFile,
    );
  }

  void _showErrorDialog(String message, BuildContext context) {
    final localizations = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(localizations!.error),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(localizations.ok),
            ),
          ],
        );
      },
    );
  }
}
