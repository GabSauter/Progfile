import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progfile/app/models/competence_model.dart';

class CompetenceController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController degreeController = TextEditingController();

  CompetenceModel generateCompetence() {
    return CompetenceModel(
      name: nameController.text,
      degree: degreeController.text,
    );
  }

  CompetenceModel editCompetence(CompetenceModel competence) {
    competence.name = nameController.text;
    competence.degree = degreeController.text;

    return competence;
  }
}
