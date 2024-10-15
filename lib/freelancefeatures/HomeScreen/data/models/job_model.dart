import '../../../authintication_screens/data/models/client_model.dart';
import '../../domain/entities/job.dart';

class JobModel extends Job {
  JobModel({
    required String id,
    required String title,
    required String description,
    required double budget,
    required DateTime deadline,
    required String clientName,
    required Client client,
    required List<String> applications,
    required bool canApply,
    String? acceptedFreelancer,
    required List<String> skills,
    String location = 'Remote',
  }) : super(
    id: id,
    title: title,
    description: description,
    budget: budget,
    deadline: deadline,
    clientName: clientName,
    client: client,
    applications: applications,
    canApply: canApply,
    acceptedFreelancer: acceptedFreelancer,
    skills: skills,
    location: location,
  );

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      budget: (json['budget'] ?? 0).toDouble(),
      deadline: DateTime.parse(json['deadline'] ?? DateTime.now().toIso8601String()),
      clientName: json['clientName'] ?? '',
      client: Client.fromJson(json['client'] ?? {}),
      applications: List<String>.from(json['applications'] ?? []),
      canApply: json['canApply'] ?? false,
      acceptedFreelancer: json['acceptedFreelancer'],
      skills: List<String>.from(json['skills'] ?? []),
      location: json['location'] ?? 'Remote',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['_id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['budget'] = budget;
    data['deadline'] = deadline.toIso8601String();
    data['clientName'] = clientName;
    data['client'] = client.toJson();
    data['applications'] = applications;
    data['canApply'] = canApply;
    data['acceptedFreelancer'] = acceptedFreelancer;
    data['skills'] = skills;
    data['location'] = location;
    return data;
  }
}