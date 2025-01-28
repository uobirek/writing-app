import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:writing_app/features/notes/widgets/dynamic_image.dart';
import 'package:writing_app/features/projects/cubit/project_cubit.dart';
import 'package:writing_app/features/projects/models/project.dart';
import 'package:writing_app/utils/gradient_text.dart';
import 'package:writing_app/utils/scaffold_messenger.dart';

class ProjectInfo extends StatefulWidget {
  const ProjectInfo({
    super.key,
    required this.project,
  });

  final Project project;

  @override
  ProjectInfoState createState() => ProjectInfoState();
}

class ProjectInfoState extends State<ProjectInfo> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String? _imagePath; // Dynamic image path
  File? _imageFile; // Selected image file
  bool _isDescriptionExpanded = false;
  bool _isEditing = false; // Track editing mode

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.project.title);
    _descriptionController =
        TextEditingController(text: widget.project.description);
    _imagePath = widget.project.imageUrl ?? 'assets/images/dottie.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header image
            GestureDetector(
              onTap: _isEditing ? _changeImage : null,
              child: DynamicImageWidget(
                imagePath: _imageFile?.path ?? _imagePath,
                width: 400,
                height: 250,
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            // Title and Save Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_isEditing)
                    Expanded(
                      child: TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Enter project title',
                        ),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    )
                  else
                    Flexible(
                      child: GradientText(
                        _titleController.text,
                        style: Theme.of(context).textTheme.titleLarge,
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.secondary,
                            Theme.of(context).colorScheme.onSecondary,
                          ],
                        ),
                      ),
                    ),
                  IconButton(
                    icon: Icon(
                      _isEditing ? Icons.save : Icons.edit,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: _isEditing
                        ? () => {_saveChanges(context)}
                        : _toggleEditing,
                  ),
                ],
              ),
            ),

            // Description Section with Expand/Collapse Feature
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: _isEditing
                    ? null
                    : () {
                        setState(() {
                          _isDescriptionExpanded = !_isDescriptionExpanded;
                        });
                      },
                child: _isEditing
                    ? TextField(
                        controller: _descriptionController,
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter project description',
                        ),
                      )
                    : Text(
                        _isDescriptionExpanded
                            ? _descriptionController.text
                            : _descriptionController.text.length > 100
                                ? '${_descriptionController.text.substring(0, 100)}...' // Preview text
                                : _descriptionController.text,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
              ),
            ),

            // Add some spacing at the bottom of the screen
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Toggle editing mode
  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _saveChanges(BuildContext context) async {
    if (!_isEditing) {
      return;
    }

    // Safely obtain the ProjectCubit reference early
    final projectCubit = context.read<ProjectCubit>();
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      // Handle the case where the user is not logged in
      if (mounted) {
        showMessage(context, 'User is not logged in');
      }
      return;
    }

    try {
      // Update the project
      final updatedProject = widget.project.copyWith(
        title: _titleController.text,
        description: _descriptionController.text,
        imageUrl: _imagePath ?? widget.project.imageUrl,
      );

      await projectCubit.updateProject(updatedProject, userId, _imageFile);

      // Fetch the updated list of projects
      await projectCubit.fetchProjectById(userId);

      if (mounted) {
        // Exit editing mode and show success message
        setState(() {
          _isEditing = false;
        });
        showMessage(context, 'Project updated succesfully');
      }
    } catch (e) {
      if (mounted) {
        // Handle errors safely
        showMessage(context, 'Failed to update project');
      }
    }
  }

  /// Change image (e.g., pick new image path)
  Future<void> _changeImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imagePath = null; // Clear existing path if a new file is selected
      });
    }
  }
}
