import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:writing_app/features/projects/cubit/project_cubit.dart';
import 'package:writing_app/features/writing/cubit/chapter_cubit.dart';
import 'package:writing_app/features/writing/cubit/chapter_state.dart';
import 'package:writing_app/features/writing/models/chapter.dart';
import 'package:writing_app/l10n/app_localizations.dart';
import 'package:writing_app/widgets/minimal_text_field.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class EditChapterScreen extends StatefulWidget {
  const EditChapterScreen({
    super.key,
    this.chapterId,
    required this.isNewChapter,
  });

  final String? chapterId;
  final bool isNewChapter;

  @override
  State<EditChapterScreen> createState() => _EditChapterScreenState();
}

class _EditChapterScreenState extends State<EditChapterScreen> {
  late QuillController _controller;
  late TextEditingController _titleController;
  late int _chapterPosition;
  bool _showToolbar = true;
  bool _isInitialized = false; // Prevent reinitialization

  @override
  void initState() {
    super.initState();

    if (!widget.isNewChapter) {
      final chapterCubit = context.read<ChapterCubit>();
      final projectCubit = context.read<ProjectCubit>();
      final project = projectCubit.selectedProject;
      chapterCubit.fetchChapters(project!.id);
    } else {
      _initializeControllers(Chapter.empty());
    }
  }

  void _initializeControllers(Chapter chapter) {
    _controller = QuillController(
      document: chapter.jsonContent != null && chapter.jsonContent!.isNotEmpty
          ? Document.fromDelta(Delta.fromJson(chapter.jsonContent!))
          : Document()
        ..insert(0, ''),
      selection: const TextSelection.collapsed(offset: 0),
    );

    _titleController = TextEditingController(text: chapter.title ?? '');
    _chapterPosition = chapter.position ?? 1; // Ensure valid initial value
  }

  void _saveChapter(BuildContext context) {
    final cubit = context.read<ChapterCubit>();
    final content = _controller.document.toPlainText();
    final jsonContent = _controller.document.toDelta().toJson();

    final chapter = Chapter(
      id: widget.isNewChapter ? '' : widget.chapterId,
      title: _titleController.text,
      position: _chapterPosition,
      content: content,
      jsonContent: jsonContent,
    );
    final projectCubit = context.read<ProjectCubit>();
    final project = projectCubit.selectedProject;

    final saveFuture = widget.isNewChapter
        ? cubit.addChapter(chapter, project!.id)
        : cubit.updateChapter(chapter, project!.id);
    final localizations = AppLocalizations.of(context);

    saveFuture.then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations!.chapterSavedSuccessfully)),
      );
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations!.failedToSaveChapter(''))),
      );
    });
  }

  bool _isMobile() {
    return Platform.isAndroid || Platform.isIOS;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<ChapterCubit, ChapterState>(
        builder: (context, state) {
          if (!widget.isNewChapter) {
            if (state is ChapterLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChapterError) {
              return Center(child: Text(state.message));
            } else if (state is ChapterLoaded && !_isInitialized) {
              final chapter = state.chapters.firstWhere(
                (c) => c.id == widget.chapterId,
                orElse: Chapter.empty,
              );
              _initializeControllers(chapter);
              _isInitialized = true; // Prevent reinitialization
            }
          }

          return SidebarLayout(
            activeRoute: '/chapters',
            child: Padding(
              padding: _isMobile()
                  ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
                  : const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Container(
                decoration: _isMobile()
                    ? null
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).canvasColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(25),
                            blurRadius: 30,
                            spreadRadius: 6,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: MinimalTextField(
                              controller: _titleController,
                              hintText: localizations!.title,
                            ),
                          ),
                          InkWell(
                            child: const Icon(Icons.save),
                            onTap: () {
                              _saveChapter(context);
                            },
                          ),
                          const SizedBox(width: 15),
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: DropdownButtonFormField<int>(
                              value: _chapterPosition.clamp(
                                1,
                                100,
                              ), // Ensure value is valid
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _chapterPosition = value; // Update state
                                  });
                                }
                              },
                              items: List.generate(
                                100,
                                (index) => DropdownMenuItem(
                                  value: index + 1,
                                  child: Text('${index + 1}'),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              _showToolbar
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                            onPressed: () {
                              _saveChapter(
                                context,
                              ); // Save changes before toggling
                              setState(() {
                                _showToolbar = !_showToolbar;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      if (_showToolbar)
                        QuillSimpleToolbar(
                          controller: _controller,
                          configurations: _isMobile()
                              ? const QuillSimpleToolbarConfigurations(
                                  customButtons: [
                                    QuillToolbarCustomButtonOptions(),
                                  ],
                                  multiRowsDisplay: false,
                                  showFontFamily: false,
                                  showFontSize: false,
                                )
                              : QuillSimpleToolbarConfigurations(
                                  customButtons: [
                                    QuillToolbarCustomButtonOptions(
                                      icon: const Icon(Icons.save),
                                      onPressed: () {
                                        _saveChapter(context);
                                      },
                                    ),
                                  ],
                                  showAlignmentButtons: true,
                                ),
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
