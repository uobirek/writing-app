import 'package:writing_app/features/notes/models/note.dart';
import 'package:writing_app/features/notes/screens/details/note_details.dart';
import 'package:writing_app/features/notes/screens/details/outline_note_details.dart';
import 'package:writing_app/features/notes/screens/editing/note_editing.dart';
import 'package:writing_app/features/notes/screens/editing/outline_note_editing.dart';

class OutlineNote extends Note {
  OutlineNote({
    required super.id,
    required super.createdAt,
    String super.imageUrl = 'assets/images/placeholder.jpg',
    this.genre,
    this.themes = const [],
    this.acts = const [],
    this.conflicts = const [],
    this.subplots = const [],
    this.notes = const [],
    required super.position,
  }) : super(category: 'Outline', title: 'Outline');
  factory OutlineNote.fromJson(Map<String, dynamic> json) {
    return OutlineNote(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      genre: json['genre'] as String?,
      themes: (json['themes'] as List<dynamic>? ?? []).cast<String>(),
      acts: (json['acts'] as List<dynamic>? ?? [])
          .map((actJson) => Act.fromJson(actJson as Map<String, dynamic>))
          .toList(),
      conflicts: (json['conflicts'] as List<dynamic>? ?? []).cast<String>(),
      subplots: (json['subplots'] as List<dynamic>? ?? []).cast<String>(),
      notes: (json['notes'] as List<dynamic>? ?? []).cast<String>(),
      position: json['position'] as int,
      imageUrl: json['imageUrl'] as String? ??
          json['image'] as String? ??
          'assets/images/placeholder.jpg',
    );
  }

  final String? genre;
  final List<String> themes;
  final List<Act> acts;
  final List<String> conflicts;
  final List<String> subplots;
  final List<String> notes;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'genre': genre,
      'themes': themes,
      'acts': acts.map((act) => act.toJson()).toList(),
      'conflicts': conflicts,
      'subplots': subplots,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'position': position,
      'category': category,
      'image': imageUrl,
      'type': 'OutlineNote',
    };
  }

  @override
  NoteDetails getNoteDetails() {
    return OutlineNoteDetails(this);
  }

  @override
  NoteEditing getNoteEditing() {
    return OutlineNoteEditing(this);
  }
}

class Act {
  Act({
    required this.heading,
    this.summary = '',
    this.plotPoints = const [],
  });
  factory Act.fromJson(Map<String, dynamic> json) {
    return Act(
      heading: json['heading'] as String,
      summary: json['summary'] as String,
      plotPoints: List<String>.from(json['plotPoints'] as List<dynamic>),
    );
  }

  String heading;
  String summary;
  final List<String> plotPoints;

  Map<String, dynamic> toJson() {
    return {
      'heading': heading,
      'summary': summary,
      'plotPoints': plotPoints,
    };
  }
}
