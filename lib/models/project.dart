class Project {
  final String id;
  final String title;
  final String description;

  Project({
    required this.id,
    required this.title,
    required this.description,
  });
  factory Project.fromJson(Map<String, dynamic> json) {
    print('Mapping project from json: $json');
    return Project(
      id: json['id'] ?? '', // Default to empty string if 'id' is missing
      title: json['title'] ??
          'Untitled', // Default to 'Untitled' if 'title' is missing
      description: json['description'] ??
          'No description', // Default to 'No description' if 'description' is missing
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  Project copyWith({
    String? id,
    String? title,
    String? description,
  }) {
    return Project(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
