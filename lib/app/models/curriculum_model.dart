import 'dart:io';

class CurriculumModel {
  File? image;
  String name;
  String email;
  String phoneNumber;
  String githubUsername;
  String address;
  String fieldOfExpertise;
  String degree;
  String aboutYou;

  CurriculumModel({
    required this.image,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.githubUsername,
    required this.address,
    required this.fieldOfExpertise,
    required this.degree,
    required this.aboutYou,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'githubUsername': githubUsername,
      'address': address,
      'fieldOfExpertise': fieldOfExpertise,
      'degree': degree,
      'aboutYou': aboutYou,
    };
  }
}
