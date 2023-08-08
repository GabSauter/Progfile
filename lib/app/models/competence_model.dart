class CompetenceModel {
  late String id;
  String name;
  String degree;

  CompetenceModel({
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
