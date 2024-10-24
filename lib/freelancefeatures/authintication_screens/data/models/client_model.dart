class Client {
  final String id;
  final String username;
  final String email;
  final String userType;
  final List<String> jobs;
  final List<String> activeProjects;
  final List<String> oldProjects;
  final int wallet;
  final String bio;
  final int rate;
  final List<String> skills;

  Client({
    required this.id,
    required this.username,
    required this.email,
    required this.userType,
    required this.jobs,
    required this.activeProjects,
    required this.oldProjects,
    required this.wallet,
    required this.bio,
    required this.rate,
    required this.skills,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['_id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      userType: json['userType'] ?? '',
      jobs: List<String>.from(json['jobs'] ?? []),
      activeProjects: List<String>.from(json['activeProjects'] ?? []),
      oldProjects: List<String>.from(json['oldProjects'] ?? []),
      wallet: json['wallet'] ?? 0,
      bio: json['bio'] ?? '',
      rate: json['rate'] ?? 0,
      skills: List<String>.from(json['skills'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'email': email,
      'userType': userType,
      'jobs': jobs,
      'activeProjects': activeProjects,
      'oldProjects': oldProjects,
      'wallet': wallet,
      'bio': bio,
      'rate': rate,
      'skills': skills,
    };
  }
}