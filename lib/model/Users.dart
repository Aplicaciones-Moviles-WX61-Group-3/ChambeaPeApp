class Users {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final DateTime birthdate;
  final String gender;
  final String hasPremium;
  final String profilePic;
  final DateTime dateCreated;
  final DateTime dateUpdated;
  final String isActive;
  final String description;
  final String userRole;
  final String otp;
  final DateTime otpGeneratedTime;
  final String isVisible;

  Users({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.birthdate,
    required this.gender,
    required this.hasPremium,
    required this.profilePic,
    required this.dateCreated,
    required this.dateUpdated,
    required this.isActive,
    required this.description,
    required this.userRole,
    required this.otp,
    required this.otpGeneratedTime,
    required this.isVisible,
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
      dateCreated: DateTime.parse(json['dateCreated']),
      dateUpdated: DateTime.parse(json['dateUpdated']),
      isActive: json['isActive'],
      description: json['description'],
      userRole: json['userRole'],
      otp: json['otp'],
      otpGeneratedTime: DateTime.parse(json['otpGeneratedTime']),
      isVisible: json['isVisible'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'firstName': firstName,
  //     'lastName': lastName,
  //     'email': email,
  //     'password': password,
  //     'phoneNumber': phoneNumber,
  //     'birthdate': birthdate.toIso8601String(),
  //     'gender': gender,
  //     'hasPremium': hasPremium,
  //     'profilePic': profilePic,
  //     'dateCreated': dateCreated.toIso8601String(),
  //     'dateUpdated': dateUpdated.toIso8601String(),
  //     'isActive': isActive,
  //     'description': description,
  //     'userRole': userRole,
  //     'otp': otp,
  //     'otpGeneratedTime': otpGeneratedTime.toIso8601String(),
  //     'isVisible': isVisible,
  //   };
  // }
}
