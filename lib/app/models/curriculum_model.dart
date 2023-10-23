import 'package:progfile/app/models/certificate_model.dart';
import 'package:progfile/app/models/competence_model.dart';
import 'package:progfile/app/models/course_model.dart';
import 'package:progfile/app/models/git_project_model.dart';
import 'package:progfile/app/models/language_model.dart';

class CurriculumModel {
  String? id;
  List<CertificateModel> certificates;
  List<CompetenceModel> competences;
  List<CourseModel> courses;
  List<GitProjectModel> gitProjects;
  List<LanguageModel> languages;

  CurriculumModel({
    required this.certificates,
    required this.competences,
    required this.courses,
    required this.gitProjects,
    required this.languages,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'certificates': certificates.map((x) => x.toMap()).toList(),
      'competences': competences.map((x) => x.toMap()).toList(),
      'courses': courses.map((x) => x.toMap()).toList(),
      'gitProjects': gitProjects.map((x) => x.toMap()).toList(),
      'languages': languages.map((x) => x.toMap()).toList(),
    };
  }

  factory CurriculumModel.fromMap(Map<String, dynamic> map) {
    return CurriculumModel(
      id: map['id'],
      certificates: List<CertificateModel>.from(
          map['certificates']?.map((x) => CertificateModel.fromMap(x))),
      competences: List<CompetenceModel>.from(
          map['competences']?.map((x) => CompetenceModel.fromMap(x))),
      courses: List<CourseModel>.from(
          map['courses']?.map((x) => CourseModel.fromMap(x))),
      gitProjects: List<GitProjectModel>.from(
          map['gitProjects']?.map((x) => GitProjectModel.fromMap(x))),
      languages: List<LanguageModel>.from(
          map['languages']?.map((x) => LanguageModel.fromMap(x))),
    );
  }
}
