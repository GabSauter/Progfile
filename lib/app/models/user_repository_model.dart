// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class UserRepositoryModel {
  final String name;
  final String email;
  final Image? image;

  UserRepositoryModel({
    required this.name,
    required this.email,
    this.image,
  });
}
