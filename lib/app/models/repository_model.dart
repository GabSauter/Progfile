class RepositoryModel {
  String? id;
  String name;
  String url;
  String description;
  String language;

  RepositoryModel({
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

  factory RepositoryModel.fromMap(Map<String, dynamic> map) {
    return RepositoryModel(
      id: map['id'],
      name: map['name'],
      url: map['url'],
      description: map['description'],
      language: map['language'],
    );
  }
}
