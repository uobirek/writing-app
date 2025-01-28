import 'package:writing_app/features/notes/models/note.dart';
import 'package:writing_app/features/notes/screens/details/note_details.dart';
import 'package:writing_app/features/notes/screens/details/worldbuilding_note_details.dart';
import 'package:writing_app/features/notes/screens/editing/note_editing.dart';
import 'package:writing_app/features/notes/screens/editing/worldbuilding_note_editing.dart';

class WorldbuildingNote extends Note {
  WorldbuildingNote({
    required super.id,
    required super.title,
    required super.createdAt,
    String super.imageUrl = 'assets/images/placeholder.jpg',
    required this.placeName,
    required this.geography,
    required this.culture,
    this.pointsOfInterest,
    required super.position,
  }) : super(category: 'Worldbuilding');
  factory WorldbuildingNote.fromJson(Map<String, dynamic> json) {
    return WorldbuildingNote(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? 'Untitled',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
      placeName: json['placeName'] as String,
      geography: json['geography'] as String?,
      culture: json['culture'] as String?,
      pointsOfInterest: (json['pointsOfInterest'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      imageUrl: json['imageUrl'] as String? ??
          json['image'] as String? ??
          'assets/images/placeholder.jpg',
      position: (json['position'] as num?)?.toInt() ?? 0,
    );
  }

  final String placeName;
  final String? geography;
  final String? culture;
  final List<String>? pointsOfInterest;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'placeName': placeName,
      'geography': geography,
      'culture': culture,
      'pointsOfInterest': pointsOfInterest,
      'image': imageUrl,
      'type': 'WorldbuildingNote',
      'position': position,
      'category': category,
    };
  }

  @override
  NoteDetails getNoteDetails() {
    return WorldbuildingNoteDetails(this);
  }

  @override
  NoteEditing getNoteEditing() {
    return WorldbuildingNoteEditing(this);
  }
}
