import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:progfile/app/models/certificate_model.dart';
import 'package:progfile/app/models/competence_model.dart';
import 'package:progfile/app/models/course_model.dart';
import 'package:progfile/app/models/curriculum_model.dart';
import 'package:progfile/app/models/git_project_model.dart';
import 'package:progfile/app/models/language_model.dart';
import 'package:progfile/app/repositories/git_project_repository.dart';

class CurriculumRepository extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  bool _loaded = false;

  GitProjectRepository _gitProjectRepository;
  String _gitUsername;

  final CurriculumModel _curriculum = CurriculumModel(
    certificates: [],
    competences: [],
    courses: [],
    gitProjects: [],
    languages: [],
  );

  CurriculumModel _myCurriculum = CurriculumModel(
    certificates: [],
    competences: [],
    courses: [],
    gitProjects: [],
    languages: [],
  );

  CurriculumModel get curriculum => _curriculum;
  CurriculumModel get myCurriculum => _myCurriculum;
  bool get isloaded => _loaded;

  CurriculumRepository(String gitUsername, GitProjectRepository gitProjectRepository)
      : _gitProjectRepository = gitProjectRepository, _gitUsername = gitUsername {
    _initRepository();
  }

  _initRepository() async {
    await getItems(FirebaseAuth.instance.currentUser!.uid);
    await getMyCurriculum();
  }

  Future<void> getMyCurriculum() async {
    _loaded = false;
    notifyListeners();

    _myCurriculum = await getItems(FirebaseAuth.instance.currentUser!.uid);
    _loaded = true;
    notifyListeners();
  }

  Future<CurriculumModel> getItems(String userId) async {
    _curriculum.courses = [];
    notifyListeners();

    await getCertificates(userId);
    await getCompetences(userId);
    await getCourses(userId);
    await getGitProjects(userId);
    await getLanguages(userId);

    notifyListeners();

    return _curriculum;
  }

  Future<void> getCertificates(String userId) async {
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

    _curriculum.certificates = certificates;

    notifyListeners();
  }

  Future<void> getCompetences(String userId) async {
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

    _curriculum.competences = competences;

    notifyListeners();
  }

  Future<void> getCourses(String userId) async {
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

    _curriculum.courses = courses;

    notifyListeners();
  }

    getGitProjects() {
    _curriculum.gitProjects = _gitProjectRepository.list;

    notifyListeners();
  }

  Future<void> getLanguages(String userId) async {
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

    _curriculum.languages = languages;

    notifyListeners();
  }

  void reset() {
    _curriculum.certificates = [];
    _curriculum.competences = [];
    _curriculum.courses = [];
    _curriculum.gitProjects = [];
    _curriculum.languages = [];

    _myCurriculum.certificates = [];
    _myCurriculum.competences = [];
    _myCurriculum.courses = [];
    _myCurriculum.gitProjects = [];
    _myCurriculum.languages = [];

    _loaded = false;
    notifyListeners();
  }

  Future<void> deleteCurriculum() async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete();

    reset();
  }
}
