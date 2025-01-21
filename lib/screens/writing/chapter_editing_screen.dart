import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:writing_app/models/project_cubit.dart';
import 'package:writing_app/screens/writing/chapter_cubit.dart';
import 'package:writing_app/screens/writing/chapter_state.dart';
import 'package:writing_app/screens/writing/models/chapter.dart';
import 'package:writing_app/widgets/custom_text_field.dart';
import 'package:writing_app/widgets/minimal_text_field.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class EditChapterScreen extends StatefulWidget {
  final String? chapterId; // Nullable for new chapters
  final bool isNewChapter;

  const EditChapterScreen({
    super.key,
    this.chapterId,
    required this.isNewChapter,
  });

  @override
  State<EditChapterScreen> createState() => _EditChapterScreenState();
}

class _EditChapterScreenState extends State<EditChapterScreen> {
  late QuillController _controller;
  late TextEditingController _titleController;
  late TextEditingController _positionController;

  @override
  void initState() {
    super.initState();

    if (!widget.isNewChapter) {
      // If editing, fetch the chapter data
      final chapterCubit = context.read<ChapterCubit>();
      final projectCubit = context.read<ProjectCubit>();
      final project = projectCubit.selectedProject;
      chapterCubit.fetchChapters(project!.id);
    } else {
      // If creating a new chapter, initialize with empty/default values
      _initializeControllers(Chapter.empty());
    }
  }

  void _initializeControllers(Chapter chapter) {
    _controller = QuillController(
      document: chapter.jsonContent != null && chapter.jsonContent!.isNotEmpty
          ? Document.fromDelta(Delta.fromJson(chapter.jsonContent!))
          : Document()
        ..insert(0, ''), // Default empty document
      selection: const TextSelection.collapsed(offset: 0),
    );

    _titleController = TextEditingController(text: chapter.title ?? '');
    _positionController =
        TextEditingController(text: chapter.position?.toString() ?? '');
  }

  void _saveChapter(BuildContext context) {
    final cubit = context.read<ChapterCubit>();
    final content =
        _controller.document.toPlainText(); // Get plain text content
    final jsonContent =
        _controller.document.toDelta().toJson(); // Get Delta JSON

    // Create or update the chapter object
    final chapter = Chapter(
      id: widget.isNewChapter ? '' : widget.chapterId,
      title: _titleController.text,
      position: int.tryParse(_positionController.text) ?? 1,
      content: content,
      jsonContent: jsonContent,
    );
    final projectCubit = context.read<ProjectCubit>();
    final project = projectCubit.selectedProject;

    final saveFuture = widget.isNewChapter
        ? cubit.addChapter(chapter, project!.id)
        : cubit.updateChapter(chapter, project!.id);

    saveFuture.then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chapter saved successfully!')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save chapter: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChapterCubit, ChapterState>(
        builder: (context, state) {
          if (!widget.isNewChapter) {
            if (state is ChapterLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChapterError) {
              return Center(child: Text(state.message));
            } else if (state is ChapterLoaded) {
              final chapter = state.chapters.firstWhere(
                (c) => c.id == widget.chapterId,
                orElse: () => Chapter.empty(),
              );
              _initializeControllers(chapter);
            }
          }

          return SidebarLayout(
            activeRoute: '/chapters',
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).canvasColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 30,
                          spreadRadius: 6,
                          offset: const Offset(0, 10)),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: MinimalTextField(
                              controller: _titleController,
                              hintText: 'Title',
                            ),
                          ),
                          const SizedBox(height: 15),
                          CustomTextField(
                            controller: _positionController,
                            label: "Number",
                            isNumber: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      QuillSimpleToolbar(
                        controller: _controller,
                        configurations:
                            QuillSimpleToolbarConfigurations(customButtons: [
                          QuillToolbarCustomButtonOptions(
                            icon: const Icon(Icons.save),
                            onPressed: () {
                              _saveChapter(context);
                            },
                          ),
                        ]),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: QuillEditor.basic(
                          controller: _controller,
                          configurations: const QuillEditorConfigurations(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
