class LanguageModel {
  String name;
  String degree;

  LanguageModel({
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
