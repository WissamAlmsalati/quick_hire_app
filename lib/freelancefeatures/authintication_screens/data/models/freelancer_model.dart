class Freelancer {
  final String id;
  final String username;
  final String email;
  final String password;
  final String userType;
  final bool isSuperUser;
  final List<String> jobs;
  final List<String> activeProjects;
  final List<dynamic> oldProjects;
  final int wallet;
  final String type;
  final List<dynamic> skills;
  final int rate;
  final List<dynamic> portfolio;
  final String bio;
  final List<dynamic> ratings;
  final int version;

  Freelancer({
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
    required this.type,
    required this.skills,
    required this.rate,
    required this.portfolio,
    required this.bio,
    required this.ratings,
    required this.version,
  });

  factory Freelancer.fromJson(Map<String, dynamic> json) {
    return Freelancer(
      id: json['_id']??'',
      username: json['username']??'',
      email: json['email']??'',
      password: json['password']??'',
      userType: json['userType']??'',
      isSuperUser: json['isSuperUser']??false,
      jobs: List<String>.from(json['jobs'])??[],
      activeProjects: List<String>.from(json['activeProjects'])??[],
      oldProjects: List<dynamic>.from(json['oldProjects'])??[],
      wallet: json['wallet']??0,
      type: json['__t']??'',
      skills: List<dynamic>.from(json['skills'])??[],
      rate: json['rate']??0,
      portfolio: List<dynamic>.from(json['portfolio'])??[],
      bio: json['bio']??'',
      ratings: List<dynamic>.from(json['ratings'])??[],
      version: json['__v']??0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'email': email,
      'password': password,
      'userType': userType,
      'isSuperUser': isSuperUser,
      'jobs': jobs,
      'activeProjects': activeProjects,
      'oldProjects': oldProjects,
      'wallet': wallet,
      '__t': type,
      'skills': skills,
      'rate': rate,
      'portfolio': portfolio,
      'bio': bio,
      'ratings': ratings,
      '__v': version,
    };
  }
}