class Chapter {
  final String? id;
  final String? title;
  final int? position;
  final String? content;
  final List<dynamic>? jsonContent;

  Chapter({
    this.id,
    this.title,
    this.position,
    this.content,
    this.jsonContent,
  });

  factory Chapter.empty() {
    return Chapter(
      id: '',
      title: '',
      position: 0,
      content: '',
      jsonContent: [],
    );
  }

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

  Chapter copyWith({
    String? id,
    String? title,
    int? position,
    String? content,
    List<dynamic>? jsonContent,
  }) {
    return Chapter(
      id: id ?? this.id,
      title: title ?? this.title,
      position: position ?? this.position,
      content: content ?? this.content,
      jsonContent: jsonContent ?? this.jsonContent,
    );
  }
}
