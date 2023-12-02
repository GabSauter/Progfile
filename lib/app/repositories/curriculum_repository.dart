import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:progfile/app/models/certificate_model.dart';
import 'package:progfile/app/models/competence_model.dart';
import 'package:progfile/app/models/course_model.dart';
import 'package:progfile/app/models/curriculum_model.dart';
import 'package:progfile/app/models/language_model.dart';
import 'package:progfile/app/repositories/git_project_repository.dart';
import 'package:progfile/app/repositories/profile_repository.dart';

class CurriculumRepository extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  bool _loaded = false;

  GitProjectRepository gitProjects;
  ProfileRepository profile;

  final CurriculumModel _curriculum = CurriculumModel(
    certificates: [],
    competences: [],
    courses: [],
    gitProjects: [],
    languages: [],
  );

  final CurriculumModel _myCurriculum = CurriculumModel(
    certificates: [],
    competences: [],
    courses: [],
    gitProjects: [],
    languages: [],
  );

  CurriculumModel get curriculum => _curriculum;
  CurriculumModel get myCurriculum => _myCurriculum;
  bool get isloaded => _loaded;

  CurriculumRepository({
    required this.gitProjects,
    required this.profile,
  });

  Future<void> getMyCurriculum() async {
    _loaded = false;
    notifyListeners();

    await getItems(user.uid);

    _loaded = true;
    notifyListeners();
  }

  Future<void> getItems(String userId) async {
    reset(userId);
    notifyListeners();

    await getCertificates(userId);
    await getCompetences(userId);
    await getCourses(userId);
    await getLanguages(userId);
    await getGitProjects(userId);

    notifyListeners();
  }

  Future<void> getGitProjects(String userId) async {
    final username = profile.getGitUsername(userId);

    if (username == '') {
      return;
    }

    if (user.uid == userId) {
      _myCurriculum.gitProjects = await gitProjects.getApiProjects(username);
    } else {
      _curriculum.gitProjects = await gitProjects.getApiProjects(username);
    }

    notifyListeners();
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

    if (user.uid == userId) {
      _myCurriculum.certificates = certificates;
    } else {
      _curriculum.certificates = certificates;
    }

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

    if (user.uid == userId) {
      _myCurriculum.competences = competences;
    } else {
      _curriculum.competences = competences;
    }

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

    if (user.uid == userId) {
      _myCurriculum.courses = courses;
    } else {
      _curriculum.courses = courses;
    }

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

    if (user.uid == userId) {
      _myCurriculum.languages = languages;
    } else {
      _curriculum.languages = languages;
    }

    notifyListeners();
  }

  void reset(String? userId) {
    if (userId != null) {
      if (user.uid == userId) {
        _myCurriculum.certificates = [];
        _myCurriculum.competences = [];
        _myCurriculum.courses = [];
        _myCurriculum.gitProjects = [];
        _myCurriculum.languages = [];
      } else {
        _curriculum.certificates = [];
        _curriculum.competences = [];
        _curriculum.courses = [];
        _curriculum.gitProjects = [];
        _curriculum.languages = [];
      }
    }

    _loaded = false;
    notifyListeners();
  }

  Future<void> deleteCurriculum() async {
    await _db.collection("curriculum").doc(user.uid).delete();

    reset(null);
  }
}
