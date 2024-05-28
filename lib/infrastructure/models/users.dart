class Users {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? password;
  final String phoneNumber;
  final DateTime birthdate;
  final String gender;
  final int? hasPremium;
  final String profilePic;
  final String description;
  final String userRole;
  final String? isVisible;

  Users({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.password,
    required this.phoneNumber,
    required this.birthdate,
    required this.gender,
    this.hasPremium,
    required this.profilePic,
    required this.description,
    required this.userRole,
    this.isVisible,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      birthdate: DateTime.parse(json['birthdate']),
      gender: json['gender'],
      hasPremium: json['hasPremium'],
      profilePic: json['profilePic'],
      description: json['description'],
      userRole: json['userRole'],
      isVisible: json['isVisible'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'birthdate': birthdate.toIso8601String(),
      'gender': gender,
      'hasPremium': hasPremium,
      'profilePic': profilePic,
      'description': description,
      'userRole': userRole,
      'isVisible': isVisible,
    };
  }
}
