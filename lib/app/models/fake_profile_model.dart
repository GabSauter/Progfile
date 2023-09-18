import 'package:progfile/app/models/competence_model.dart';
import 'package:progfile/app/models/course_model.dart';
import 'package:progfile/app/models/language_model.dart';
import 'package:progfile/app/models/repository_model.dart';

import 'user_repository_model.dart';

class FakeProfileModel {
  final UserRepositoryModel userRepository;
  final CourseModel courses;
  final LanguageModel languages;
  final CompetenceModel competences;
  final RepositoryModel repositories;

  FakeProfileModel({
    required this.userRepository,
    required this.courses,
    required this.languages,
    required this.competences,
    required this.repositories,
  });
}
