import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:progfile/app/models/certificate_model.dart';
import 'package:progfile/app/models/competence_model.dart';
import 'package:progfile/app/models/course_model.dart';
import 'package:progfile/app/models/curriculum_model.dart';
import 'package:progfile/app/models/git_project_model.dart';
import 'package:progfile/app/models/language_model.dart';

class CurriculumRepository extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  List<CertificateModel> certificates = [];
  List<CompetenceModel> competences = [];
  List<CourseModel> courses = [];
  List<GitProjectModel> gitProjects = [];
  List<LanguageModel> languages = [];

  CurriculumRepository() {
    _initRepository();
  }

  _initRepository() async {
    await getItems(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<CurriculumModel> getItems(String userId) async {
    CurriculumModel curriculum = CurriculumModel(
      certificates: [],
      competences: [],
      courses: [],
      gitProjects: [],
      languages: [],
    );

    certificates = await getCertificates(userId);
    competences = await getCompetences(userId);
    courses = await getCourses(userId);
    gitProjects = await getGitProjects(userId);
    languages = await getLanguages(userId);

    curriculum.certificates = certificates;
    curriculum.competences = competences;
    curriculum.courses = courses;
    curriculum.gitProjects = gitProjects;
    curriculum.languages = languages;

    return curriculum;
  }

  Future<List<CertificateModel>> getCertificates(String userId) async {
    List<CertificateModel> certificates = [];

    final snapshot = await _db
        .collection("curriculum")
        .doc(userId)
        .collection("certificate")
        .get();

    for (var doc in snapshot.docs) {
      CertificateModel certificate = CertificateModel.fromMap(doc.data());
      certificate.id = doc.id;
      certificates.add(certificate);
    }

    return certificates;
  }

  Future<List<CompetenceModel>> getCompetences(String userId) async {
    List<CompetenceModel> competences = [];

    final snapshot = await _db
        .collection("curriculum")
        .doc(userId)
        .collection("competence")
        .get();

    for (var doc in snapshot.docs) {
      CompetenceModel competence = CompetenceModel.fromMap(doc.data());
      competence.id = doc.id;
      competences.add(competence);
    }

    return competences;
  }

  Future<List<CourseModel>> getCourses(String userId) async {
    List<CourseModel> courses = [];

    final snapshot = await _db
        .collection("curriculum")
        .doc(userId)
        .collection("course")
        .get();

    for (var doc in snapshot.docs) {
      CourseModel course = CourseModel.fromMap(doc.data());
      course.id = doc.id;
      courses.add(course);
    }

    return courses;
  }

  Future<List<GitProjectModel>> getGitProjects(String userId) async {
    List<GitProjectModel> gitProjects = [];

    final snapshot = await _db
        .collection("curriculum")
        .doc(userId)
        .collection("gitProject")
        .get();

    for (var doc in snapshot.docs) {
      GitProjectModel gitProject = GitProjectModel.fromMap(doc.data());
      gitProject.id = doc.id;
      gitProjects.add(gitProject);
    }

    return gitProjects;
  }

  Future<List<LanguageModel>> getLanguages(String userId) async {
    List<LanguageModel> languages = [];

    final snapshot = await _db
        .collection("curriculum")
        .doc(userId)
        .collection("language")
        .get();

    for (var doc in snapshot.docs) {
      LanguageModel language = LanguageModel.fromMap(doc.data());
      language.id = doc.id;
      languages.add(language);
    }

    return languages;
  }
}
