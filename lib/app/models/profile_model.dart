class ProfileModel {
  String? id;
  String? image;
  String name;
  String email;
  String phoneNumber;
  String? githubUsername;
  String address;
  String fieldOfExpertise;
  String degree;
  String aboutYou;

  ProfileModel({
    this.id,
    this.image,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.githubUsername,
    required this.address,
    required this.fieldOfExpertise,
    required this.degree,
    required this.aboutYou,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'email': email,
      'phoneNumber': phoneNumber,
      'githubUsername': githubUsername,
      'address': address,
      'fieldOfExpertise': fieldOfExpertise,
      'degree': degree,
      'aboutYou': aboutYou,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'],
      image: map['image'],
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      githubUsername: map['githubUsername'],
      address: map['address'],
      fieldOfExpertise: map['fieldOfExpertise'],
      degree: map['degree'],
      aboutYou: map['aboutYou'],
    );
  }
}
