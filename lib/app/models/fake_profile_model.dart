import 'package:progfile/app/models/competence_model.dart';
import 'package:progfile/app/models/course_model.dart';
import 'package:progfile/app/models/language_model.dart';
import 'package:progfile/app/models/git_project_model.dart';

import 'user_repository_model.dart';

class FakeProfileModel {
  final UserRepositoryModel userRepository;
  final CourseModel courses;
  final LanguageModel languages;
  final CompetenceModel competences;
  final GitProjectModel repositories;

  FakeProfileModel({
    required this.userRepository,
    required this.courses,
    required this.languages,
    required this.competences,
    required this.repositories,
  });
}
