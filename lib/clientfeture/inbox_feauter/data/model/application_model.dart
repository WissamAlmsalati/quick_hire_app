// lib/clientfeture/inbox_feature/data/models/application_model.dart
class ApplicationModel {
  final String id;
  final String username;
  final String email;

  ApplicationModel({required this.id, required this.username, required this.email});

  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    return ApplicationModel(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
    );
  }
}