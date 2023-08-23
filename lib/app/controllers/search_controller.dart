import 'package:flutter/material.dart';
import 'package:progfile/app/models/curriculum_model.dart';

class SearchCurriculumController {
  final TextEditingController searchTextController = TextEditingController();

  final List<CurriculumModel> resumes = [
    CurriculumModel(
        image: null,
        name: "Gabriel",
        email: "gabriel@gmail.com",
        phoneNumber: "1234567891",
        gitHubRepositoryUrl: "www.github.com",
        address: "Adress",
        fieldOfExpertise: "Desenvolvedor Android",
        degree: "Estágio",
        aboutYou: "Sobre Você"),
    CurriculumModel(
        image: null,
        name: "José",
        email: "José@gmail.com",
        phoneNumber: "1234567891",
        gitHubRepositoryUrl: "www.github.com",
        address: "Adress",
        fieldOfExpertise: "Desenvolvedor Web",
        degree: "Pleno",
        aboutYou: "Sobre Você"),
    CurriculumModel(
        image: null,
        name: "Fabio",
        email: "Fabio@gmail.com",
        phoneNumber: "1234567891",
        gitHubRepositoryUrl: "www.github.com",
        address: "Adress",
        fieldOfExpertise: "Engenheiro de Software",
        degree: "Estágio",
        aboutYou: "Sobre Você"),
    CurriculumModel(
        image: null,
        name: "Gabriel",
        email: "gabriel@gmail.com",
        phoneNumber: "1234567891",
        gitHubRepositoryUrl: "www.github.com",
        address: "Adress",
        fieldOfExpertise: "Desenvolvedor Android",
        degree: "Estágio",
        aboutYou: "Sobre Você")
  ];

  searchResumes(String searchText) {
    return resumes
        .where((resume) =>
            resume.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }
}
