class Project {
  final String id;
  final String title;
  final String description;
  final String? imageUrl; // Add image URL

  Project({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl, // Optional image URL
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    print('Mapping project from json: $json');
    return Project(
      id: json['id'] ?? '',
      title: json['title'] ?? 'Untitled',
      description: json['description'] ?? 'No description',
      imageUrl: json['imageUrl'], // Fetch image from JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl, // Include image in JSON
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
