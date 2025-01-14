import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:writing_app/widgets/custom_text_field.dart';
import 'package:writing_app/widgets/minimal_text_field.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';
import 'package:writing_app/screens/writing/chapter_state.dart';
import 'package:writing_app/screens/writing/models/chapter.dart';
import 'package:writing_app/screens/writing/chapter_cubit.dart';

class EditChapterScreen extends StatefulWidget {
  final String chapterId;

  const EditChapterScreen({super.key, required this.chapterId});

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
    // Fetch chapters when the screen is initialized
    final chapterCubit = context.read<ChapterCubit>();
    chapterCubit.fetchChapters();
  }

  void _initializeControllers(Chapter chapter) {
    // Initialize the controllers with the chapter data
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
      id: widget.chapterId,
      title: _titleController.text,
      position: int.tryParse(_positionController.text) ?? 1,
      content: content,
      jsonContent: jsonContent,
    );

    // Call Cubit to save or update the chapter
    cubit.updateChapter(chapter).then((_) {
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
          if (state is ChapterLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChapterError) {
            return Center(child: Text(state.message));
          } else if (state is ChapterLoaded) {
            final chapter = state.chapters.firstWhere(
              (c) => c.id == widget.chapterId,
              orElse: () => Chapter.empty(),
            );

            // Initialize the controllers only after the chapter data is loaded
            _initializeControllers(chapter);

            return SidebarLayout(
              activeRoute: '/chapters',
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Field
                    Row(
                      children: [
                        Expanded(
                          child: MinimalTextField(
                            controller: _titleController,
                            hintText: 'Title',
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Position Field
                        CustomTextField(
                          controller: _positionController,
                          label: "Number",
                          isNumber: true,
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // Quill Editor Toolbar
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

                    // Quill Editor
                    Expanded(
                      child: QuillEditor.basic(
                        controller: _controller,
                        configurations: const QuillEditorConfigurations(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('No chapters available.'));
          }
        },
      ),
    );
  }
}
