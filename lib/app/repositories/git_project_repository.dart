import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/git_project_model.dart';

class GitProjectRepository extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final List<GitProjectModel> _favorites = [];

  Future<void> getFavoriteProjects() async {
    _favorites.clear();

    final snapshot = await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("gitProject")
        .get();

    for (var doc in snapshot.docs) {
      GitProjectModel project = GitProjectModel.fromMapDB(doc.data());
      project.id = doc.id;
      _favorites.add(project);
    }

    notifyListeners();
  }

  Future<List<GitProjectModel>> getApiProjects(String username) async {
    List<GitProjectModel> projects = [];

    if (username == '') {
      return [];
    }

    projects.clear();
    notifyListeners();

    String url = "https://api.github.com/users/$username/repos";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> repos = json.decode(response.body);

      for (var repo in repos) {
        GitProjectModel project = GitProjectModel.fromMap(repo);
        projects.add(project);
      }

      notifyListeners();
      return projects;
    }
    return [];
  }

  Future<void> create(GitProjectModel project) async {
    final doc = await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("gitProject")
        .add(project.toMap());

    project.id = doc.id;
    _favorites.add(project);

    notifyListeners();
  }

  Future<void> edit(GitProjectModel project) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("gitProject")
        .doc(project.id)
        .update(project.toMap());

    int indexToEdit = _favorites.indexWhere((proj) => proj.id == project.id);
    _favorites[indexToEdit] = project;

    notifyListeners();
  }

  Future<void> delete(String projectId) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("gitProject")
        .doc(projectId)
        .delete();

    _favorites.removeWhere((proj) => proj.id == projectId);

    notifyListeners();
  }
}
