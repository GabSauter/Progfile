class LanguageModel {
  String? id;
  String name;
  String degree;

  LanguageModel({
    this.id,
    required this.name,
    required this.degree,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'degree': degree,
    };
  }
}
