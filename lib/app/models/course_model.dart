class CourseModel {
  String? id;
  String name;
  String university;
  String degree;
  String startDate;
  String finishDate;

  CourseModel({
    this.id,
    required this.name,
    required this.university,
    required this.degree,
    required this.startDate,
    required this.finishDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'university': university,
      'degree': degree,
      'startDate': startDate,
      'finishDate': finishDate,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'],
      name: map['name'],
      university: map['university'],
      degree: map['degree'],
      startDate: map['startDate'],
      finishDate: map['finishDate'],
    );
  }
}
