import '../../../authintication_screens/data/models/client_model.dart';

class Job {
  final String id;
  final String title;
  final String description;
  final double budget;
  final DateTime deadline;
  final String clientName;
  final Client client;
  final List<dynamic> applications; // Changed to List<dynamic>
  final bool canApply;
  final String? acceptedFreelancer;
  final List<String> skills;
  final String location;

  Job({
    required this.id,
    required this.title,
    required this.description,
    required this.budget,
    required this.deadline,
    required this.clientName,
    required this.client,
    required this.applications,
    required this.canApply,
    this.acceptedFreelancer,
    required this.skills,
    this.location = 'Remote',
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      budget: (json['budget'] as num).toDouble(),
      deadline: DateTime.parse(json['deadline']),
      clientName: json['clientName'],
      client: Client.fromJson(json['client']),
      applications: json['applications'], // No conversion here
      canApply: json['canApply'],
      acceptedFreelancer: json['acceptedFreelancer'],
      skills: List<String>.from(json['skills']),
      location: json['location'] ?? 'Remote',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'budget': budget,
      'deadline': deadline.toIso8601String(),
      'clientName': clientName,
      'client': client.toJson(),
      'applications': applications,
      'canApply': canApply,
      'acceptedFreelancer': acceptedFreelancer,
      'skills': skills,
      'location': location,
    };
  }
}