class Note {
  final String id; // Unique identifier for each note
  final String title; // Title of the note
  final String content; // Full content of the note
  final String
      category; // Category of the note (e.g., Worldbuilding, Characters)
  final String? image; // Optional: Image for the note
  final DateTime createdAt; // Date when the note was created

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    this.image,
    required this.createdAt,
  });

  // Method to convert a Note to a JSON map (for persistent storage)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'image': image,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Method to create a Note from a JSON map
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      category: json['category'],
      image: json['image'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
