class GitProjectModel {
  String? id;
  String name;
  String url;
  String description;
  String language;

  GitProjectModel({
    this.id,
    required this.name,
    required this.url,
    required this.description,
    required this.language,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
      'description': description,
      'language': language,
    };
  }

  factory GitProjectModel.fromMap(Map<String, dynamic> map) {
    return GitProjectModel(
      id: map['id'],
      name: map['name'],
      url: map['url'],
      description: map['description'],
      language: map['language'],
    );
  }
}
