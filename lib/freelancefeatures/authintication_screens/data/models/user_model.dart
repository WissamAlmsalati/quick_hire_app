class User {
  String id;
  String username;
  String email;
  String password;
  String userType;
  bool isSuperUser;
  List<String> jobs;
  List<String> activeProjects;
  List<String> oldProjects;
  int wallet;
  String token; // Add the token field

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.userType,
    required this.isSuperUser,
    required this.jobs,
    required this.activeProjects,
    required this.oldProjects,
    required this.wallet,
    required this.token, // Add the token field to the constructor
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
      token: json['token'] ?? '', // Add the token field to fromJson
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'userType': userType,
      'isSuperUser': isSuperUser,
      'jobs': jobs,
      'activeProjects': activeProjects,
      'oldProjects': oldProjects,
      'wallet': wallet,
      'token': token, // Add the token field to toJson
    };
  }
}