import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progfile/app/models/competence_model.dart';
import 'package:progfile/app/services/competence_service.dart';

class CompetenceController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController degreeController = TextEditingController();

  Future<List<CompetenceModel>> getCompetences() async {
    return await CompetenceService().getAll();
  }

  void addCompetence() async {
    CompetenceModel competence = CompetenceModel(
      name: nameController.text,
      degree: degreeController.text,
    );
    await CompetenceService().create(competence);
  }

  void editCompetence(CompetenceModel competence) async {
    competence.name = nameController.text;
    competence.degree = degreeController.text;

    await CompetenceService().edit(competence.id, competence);
  }

  void removeCompetence(String id) async {
    await CompetenceService().delete(id);
  }
}
