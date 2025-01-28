class Project {
  Project({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? 'Untitled',
      description: json['description'] as String? ?? 'No description',
      imageUrl: json['imageUrl'] as String?,
    );
  }
  final String id;
  final String title;
  final String description;
  final String? imageUrl;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  Project copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
  }) {
    return Project(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
