import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/git_project_model.dart';

class GitProjectRepository extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final List<GitProjectModel> _projects = [];

  UnmodifiableListView<GitProjectModel> get list =>
      UnmodifiableListView(_projects);

  // fazer o construtor pegar o username do git para puxar os projetos.
  // fazer uma condicao para que o getProjects pegue os projetos somente se o
  // o username do git estiver preenchido.
  // fazer a logica para quando puxar do git e quando puxar do banco de dados,
  // sempre puxar do banco no primeiro loading e quando o username do git for
  // adicionado ou alterado preencher o banco,

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
