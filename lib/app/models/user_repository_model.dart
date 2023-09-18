// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class UserRepositoryModel {
  final String name;
  final String email;
  final Image? image;
  final String phone;
  final String city;
  final String uf;
  final String about;

  UserRepositoryModel({
    required this.name,
    required this.email,
    this.image,
    required this.phone,
    required this.city,
    required this.uf,
    required this.about,
  });

  get languages => null;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'image': image,
      'phone': phone,
      'city': city,
      'state': uf,
      'about': about,
    };
  }
}
