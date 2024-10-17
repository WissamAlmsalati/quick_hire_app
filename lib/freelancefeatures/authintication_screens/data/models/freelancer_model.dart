import 'user_model.dart';

class Freelancer extends User {
  List<String> skills;
  int rate;
  List<String> portfolio;
  String bio;
  List<int> ratings;

  Freelancer({
    required String id,
    required String username,
    required String email,
    required String password,
    required String userType,
    required bool isSuperUser,
    required List<String> jobs,
    required List<String> activeProjects,
    required List<String> oldProjects,
    required int wallet,
    required String token,
    required this.skills,
    required this.rate,
    required this.portfolio,
    required this.bio,
    required this.ratings,
  }) : super(
    id: id,
    username: username,
    email: email,
    password: password,
    userType: userType,
    isSuperUser: isSuperUser,
    jobs: jobs,
    activeProjects: activeProjects,
    oldProjects: oldProjects,
    wallet: wallet,
    token: token,
  );

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