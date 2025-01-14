class Chapter {
  final String id;
  final String? title;
  final int? position;
  final String? content; // Plain text content
  final List<dynamic>? jsonContent; // Delta JSON for rich text

  Chapter({
    required this.id,
    this.title,
    this.position,
    this.content,
    this.jsonContent,
  });

  // Constructor for an empty chapter
  factory Chapter.empty() {
    return Chapter(
      id: '',
      title: '',
      position: 0,
      content: '',
      jsonContent: [],
    );
  }

  // From and to JSON methods
  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json['id'],
        title: json['title'],
        position: json['position'],
        content: json['content'],
        jsonContent: json['jsonContent'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'position': position,
        'content': content,
        'jsonContent': jsonContent,
      };
}
