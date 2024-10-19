class ActiveJob {
  final String id;
  final String title;
  final String description;
  final int budget;
  final DateTime deadline;
  final List<String> skills;
  final String location;
  final String clientName;

  ActiveJob({
    required this.id,
    required this.title,
    required this.description,
    required this.budget,
    required this.deadline,
    required this.skills,
    required this.location,
    required this.clientName,
  });

  factory ActiveJob.fromJson(Map<String, dynamic> json) {
    return ActiveJob(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      budget: json['budget'],
      deadline: DateTime.parse(json['deadline']),
      skills: List<String>.from(json['skills']),
      location: json['location'],
      clientName: json['clientName'],
    );
  }
}