import 'package:writing_app/screens/notes/editing/note_editing.dart';
import 'package:writing_app/screens/notes/editing/worldbuilding_note_editing.dart';
import 'package:writing_app/screens/notes/models/note.dart';
import 'package:writing_app/screens/notes/note_details/note_details.dart';
import 'package:writing_app/screens/notes/note_details/worldbuilding_note_details.dart';

class WorldbuildingNote extends Note {
  final String placeName; // Name of the place
  final String? geography; // Description of geography
  final String? culture; // Culture or societal description
  final List<String>? pointsOfInterest; // List of important locations

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
  }) : super(category: "Worldbuilding");

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
      'category': category
    };
  }

  factory WorldbuildingNote.fromJson(Map<String, dynamic> json) {
    return WorldbuildingNote(
      id: json['id'],
      title: json['title'],
      createdAt: DateTime.parse(json['createdAt']),
      placeName: json['placeName'],
      geography: json['geography'],
      culture: json['culture'],
      pointsOfInterest: List<String>.from(json['pointsOfInterest']),
      imageUrl:
          json['imageUrl'] ?? json['image'] ?? 'assets/images/placeholder.jpg',
      position: json['position'],
    );
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
