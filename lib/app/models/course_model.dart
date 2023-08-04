class CourseModel {
  String name;
  String university;
  String degree;
  String startDate;
  String finishDate;

  CourseModel({
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
}
