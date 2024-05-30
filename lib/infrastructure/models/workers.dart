import 'package:chambeape/infrastructure/models/users.dart';

class Workers {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final int hasPremium;
  final String profilePic;
  final int isActive;
  final String description;
  final String occupation;

  Workers({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.hasPremium,
    required this.profilePic,
    required this.isActive,
    required this.description,
    required this.occupation,
  });

  factory Workers.fromJson(Map<String, dynamic> json) {
    return Workers(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      hasPremium: json['hasPremium'],
      profilePic: json['profilePic'],
      isActive: json['isActive'],
      description: json['description'],
      occupation: json['occupation'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'hasPremium': hasPremium,
        'profilePic': profilePic,
        'isActive': isActive,
        'description': description,
        'occupation': occupation,
      };

  Users toUser() {
    return Users(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      birthdate: DateTime.now(),
      gender: 'M',
      profilePic: profilePic,
      description: description,
      userRole: 'W',
      dni: '',
    );
  }
}
