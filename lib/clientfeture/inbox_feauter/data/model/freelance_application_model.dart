// lib/models/application_model.dart
class FreelanceApplication {
  final String id;
  final String username;
  final String email;
  final String userType;
  final bool isSuperUser;
  final int wallet;
  final int rate;
  final String bio;

  FreelanceApplication({
    required this.id,
    required this.username,
    required this.email,
    required this.userType,
    required this.isSuperUser,
    required this.wallet,
    required this.rate,
    required this.bio,
  });

  factory FreelanceApplication.fromJson(Map<String, dynamic> json) {
    return FreelanceApplication(
      id: json['_id']??'',
      username: json['username']??'',
      email: json['email']??'',
      userType: json['userType']??'',
      isSuperUser: json['isSuperUser']??false,
      wallet: json['wallet']??0,
      rate: json['rate']??0,
      bio: json['bio']??'',
    );
  }
}

class ApplicationsResponse {
  final List<FreelanceApplication> applications;

  ApplicationsResponse({required this.applications});

  factory ApplicationsResponse.fromJson(Map<String, dynamic> json) {
    return ApplicationsResponse(
      applications: (json['applications'] as List)
          .map((i) => FreelanceApplication.fromJson(i))
          .toList(),
    );
  }
}