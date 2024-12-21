abstract class Note {
  final String id; // Unique identifier for each note
  final String title; // Title of the note
  final DateTime createdAt;
  final String? image; // Date when the note was created
  final String category;

  Note(
      {required this.id,
      required this.title,
      required this.createdAt,
      required this.image,
      required this.category});

  // Abstract method to convert a Note to a JSON map
  Map<String, dynamic> toJson();

  // Abstract method to create a Note from a JSON map
  static Note fromJson(Map<String, dynamic> json) {
    throw UnimplementedError("Use specific subclass factory methods");
  }
}
