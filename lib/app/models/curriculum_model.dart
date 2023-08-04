import 'dart:io';

import 'package:progfile/app/models/certificate_model.dart';
import 'package:progfile/app/models/competence_model.dart';
import 'package:progfile/app/models/course_model.dart';
import 'package:progfile/app/models/language_model.dart';

class CurriculumModel {
  File image;
  String name;
  String email;
  String phoneNumber;
  String gitHubRepositoryUrl;
  String address;
  String fieldOfExpertise;
  String degree;
  String aboutYou;
  List<CourseModel> courses;
  List<CertificateModel> certificates;
  List<LanguageModel> languages;
  List<CompetenceModel> skills;

  CurriculumModel({
    required this.image,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.gitHubRepositoryUrl,
    required this.address,
    required this.fieldOfExpertise,
    required this.degree,
    required this.aboutYou,
    required this.courses,
    required this.certificates,
    required this.languages,
    required this.skills,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'gitHubRepositoryUrl': gitHubRepositoryUrl,
      'address': address,
      'fieldOfExpertise': fieldOfExpertise,
      'degree': degree,
      'aboutYou': aboutYou,
      'courses': courses.map((course) => course.toMap()).toList(),
      'certificates':
          certificates.map((certificate) => certificate.toMap()).toList(),
      'languages': languages.map((language) => language.toMap()).toList(),
      'skills': skills.map((skill) => skill.toMap()).toList(),
    };
  }
}
