import 'user_model.dart';

class Client extends User {
  String companyName;
  List<String> projects;

  Client({
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
    required this.companyName,
    required this.projects,
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
  );

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      userType: json['userType'],
      isSuperUser: json['isSuperUser'],
      jobs: List<String>.from(json['jobs']),
      activeProjects: List<String>.from(json['activeProjects']),
      oldProjects: List<String>.from(json['oldProjects']),
      wallet: json['wallet'],
      companyName: json['companyName'],
      projects: List<String>.from(json['projects']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['companyName'] = companyName;
    data['projects'] = projects;
    return data;
  }
}