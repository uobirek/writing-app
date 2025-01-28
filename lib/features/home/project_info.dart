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
  String? _imagePath;
  File? _imageFile;
  bool _isDescriptionExpanded = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.project.title);
    _descriptionController =
        TextEditingController(text: widget.project.description);
    _imagePath = widget.project.imageUrl ?? 'assets/images/placeholder.png';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _isEditing ? _changeImage : null,
              child: DynamicImageWidget(
                imagePath: _imageFile?.path ?? _imagePath,
                width: 400,
                height: 250,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
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
                                ? '${_descriptionController.text.substring(0, 100)}...'
                                : _descriptionController.text,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _saveChanges(BuildContext context) async {
    if (!_isEditing) {
      return;
    }

    final projectCubit = context.read<ProjectCubit>();
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      if (mounted) {
        showMessage(context, 'User is not logged in');
      }
      return;
    }

    try {
      final updatedProject = widget.project.copyWith(
        title: _titleController.text,
        description: _descriptionController.text,
        imageUrl: _imagePath ?? widget.project.imageUrl,
      );

      await projectCubit.updateProject(updatedProject, userId, _imageFile);

      await projectCubit.fetchProjectById(userId);

      if (mounted) {
        setState(() {
          _isEditing = false;
        });
        showMessage(context, 'Project updated succesfully');
      }
    } catch (err) {
      if (mounted) {
        showMessage(context, 'Failed to update project');
      }
    }
  }

  Future<void> _changeImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imagePath = null;
      });
    }
  }
}
