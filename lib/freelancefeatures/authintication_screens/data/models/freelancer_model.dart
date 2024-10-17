import 'user_model.dart';

class Freelancer extends User {
  List<String> skills;
  int rate;
  List<String> portfolio;
  String bio;
  List<int> ratings;

  Freelancer({
    required super.id,
    required super.username,
    required super.email,
    required super.password,
    required super.userType,
    required super.isSuperUser,
    required super.jobs,
    required super.activeProjects,
    required super.oldProjects,
    required super.wallet,
    required super.token,
    required this.skills,
    required this.rate,
    required this.portfolio,
    required this.bio,
    required this.ratings,
  });

  factory Freelancer.fromJson(Map<String, dynamic> json) {
    return Freelancer(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      userType: json['userType'] ?? '',
      isSuperUser: json['isSuperUser'] ?? false,
      jobs: List<String>.from(json['jobs'] ?? []),
      activeProjects: List<String>.from(json['activeProjects'] ?? []),
      oldProjects: List<String>.from(json['oldProjects'] ?? []),
      wallet: json['wallet'] ?? 0,
      token: json['token'] ?? '',
      skills: List<String>.from(json['skills'] ?? []),
      rate: json['rate'] ?? 0,
      portfolio: List<String>.from(json['portfolio'] ?? []),
      bio: json['bio'] ?? '',
      ratings: List<int>.from(json['ratings'] ?? []),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['skills'] = skills;
    data['rate'] = rate;
    data['portfolio'] = portfolio;
    data['bio'] = bio;
    data['ratings'] = ratings;
    return data;
  }
}