class RepositoryModel {
  late String id;
  String name;
  String url;
  String description;
  String language;

  RepositoryModel({
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
}
