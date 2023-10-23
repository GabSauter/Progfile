class CompetenceModel {
  String? id;
  String name;
  String degree;

  CompetenceModel({
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

  factory CompetenceModel.fromMap(Map<String, dynamic> map) {
    return CompetenceModel(
      id: map['id'],
      name: map['name'],
      degree: map['degree'],
    );
  }
}
