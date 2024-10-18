import '../../../authintication_screens/data/models/client_model.dart';
import '../../domain/entities/job.dart';



import '../../../authintication_screens/data/models/client_model.dart';
import '../../domain/entities/job.dart';

class JobModel extends Job {
  JobModel({
    required super.id,
    required super.title,
    required super.description,
    required super.budget,
    required super.deadline,
    required super.clientName,
    required super.client,
    required super.applications,
    required super.canApply,
    super.acceptedFreelancer,
    required super.skills,
    super.location,
  });

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