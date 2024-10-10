
import '../../domain/entities/job.dart';

class JobModel extends Job {
  JobModel({
    required String id,
    required String title,
    required String description,
    required double budget,
    required DateTime deadline,
  }) : super(
    id: id,
    title: title,
    description: description,
    budget: budget,
    deadline: deadline,
  );

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      budget: json['budget'].toDouble(),
      deadline: DateTime.parse(json['deadline']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'budget': budget,
      'deadline': deadline.toIso8601String(),
    };
  }
}
