import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/git_project_model.dart';

class GitProjectRepository extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final List<GitProjectModel> _projects = [];
  final List<GitProjectModel> _projectsApi = [];

  UnmodifiableListView<GitProjectModel> get list =>
      UnmodifiableListView(_projects);

  UnmodifiableListView<GitProjectModel> get listApi =>
      UnmodifiableListView(_projectsApi);

  getProjects() async {
    _projects.clear();

    final snapshot = await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("gitProject")
        .get();

    for (var doc in snapshot.docs) {
      GitProjectModel project = GitProjectModel.fromMap(doc.data());
      project.id = doc.id;
      _projects.add(project);
    }

    String username = "oi";
    String url = "https://api.github.com/users/Ninjaalpha01/repos";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> repos = response.body as List;
      print(repos[0]["name"] + 'bananou');
    } else {
      print(response.statusCode);
    }

    notifyListeners();
  }

  Future<void> create(GitProjectModel project) async {
    final doc = await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("gitProject")
        .add(project.toMap());

    project.id = doc.id;
    _projects.add(project);

    notifyListeners();
  }

  Future<void> edit(GitProjectModel project) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("gitProject")
        .doc(project.id)
        .update(project.toMap());

    int indexToEdit = _projects.indexWhere((proj) => proj.id == project.id);
    _projects[indexToEdit] = project;

    notifyListeners();
  }

  Future<void> delete(String projectId) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("gitProject")
        .doc(projectId)
        .delete();

    _projects.removeWhere((proj) => proj.id == projectId);

    notifyListeners();
  }
}
