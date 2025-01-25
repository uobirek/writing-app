import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:writing_app/features/projects/cubit/project_cubit.dart';
import 'package:writing_app/features/projects/cubit/project_states.dart';
import 'package:writing_app/features/projects/models/project.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Project'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<ProjectCubit, ProjectState>(
          listener: (context, state) {
            if (state is ProjectError) {
              _showErrorDialog(state.message);
            } else if (state is ProjectLoaded) {
              Navigator.pop(
                context,
              ); // Close the screen after successful addition
            }
          },
          builder: (context, state) {
            return Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Project Title',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a project title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Project Description',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      if (_imageFile == null)
                        const Text('No image selected')
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
                    onPressed: _addProject,
                    child: state is ProjectUpdating
                        ? const CircularProgressIndicator()
                        : const Text('Add Project'),
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

  void _addProject() {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      _showErrorDialog('Please fill in all fields');
      return;
    }

    final newProject = Project(
      id: '', // Leave the ID empty for now; it will be set on the backend
      title: _titleController.text,
      description: _descriptionController.text,
    );

    BlocProvider.of<ProjectCubit>(context).addProject(
      newProject,
      widget.userId,
      _imageFile,
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
