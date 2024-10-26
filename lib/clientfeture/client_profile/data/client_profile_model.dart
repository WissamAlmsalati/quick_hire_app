// client_profile_model.dart
class ClientProfile {
  final String id;
  final String username;
  final String email;
  final String bio;
  final List<String> skills;
  final int rate;
  final List<String> jobs;
  final List<String> activeProjects;
  final List<String> oldProjects;
  final int wallet;

  ClientProfile({
    required this.id,
    required this.username,
    required this.email,
    required this.bio,
    required this.skills,
    required this.rate,
    required this.jobs,
    required this.activeProjects,
    required this.oldProjects,
    required this.wallet,
  });

  factory ClientProfile.fromJson(Map<String, dynamic> json) {
    return ClientProfile(
      id: json['_id']??'',
      username: json['username']??'',
      email: json['email']??'',
      bio: json['bio']??'',
      skills: List<String>.from(json['skills'])??[],
      rate: json['rate']??0,
      jobs: List<String>.from(json['jobs'])??[],
      activeProjects: List<String>.from(json['activeProjects'])??[],
      oldProjects: List<String>.from(json['oldProjects'])??[],
      wallet: json['wallet']??0,
    );
  }
}