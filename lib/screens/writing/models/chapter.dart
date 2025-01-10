class Chapter {
  final String id; // Unique ID for Firestore and app
  final String title; // Chapter title
  final String content; // Main text/content of the chapter
  final int position; // Position/order in the story

  Chapter({
    required this.id,
    required this.title,
    required this.content,
    required this.position,
  });

  // Convert Chapter to JSON for Firestore
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'position': position,
    };
  }

  // Create a Chapter object from Firestore JSON
  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      position: json['position'] as int,
    );
  }

  // Allow copying with modifications (useful for updates)
  Chapter copyWith({
    String? id,
    String? title,
    String? content,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Chapter(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      position: position ?? this.position,
    );
  }
}
