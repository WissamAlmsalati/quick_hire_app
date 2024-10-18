class PostedJob {
  final String id;
  final String title;
  final String description;
  final int budget;
  final DateTime deadline;
  final List<String> skills;
  final String location;
  final String clientName;
  final bool isCompleted;
  final String client;
  final List<String> applications;
  final bool canApply;
  final int version;
  final String? acceptedFreelancer;

  PostedJob({
    required this.id,
    required this.title,
    required this.description,
    required this.budget,
    required this.deadline,
    required this.skills,
    required this.location,
    required this.clientName,
    required this.isCompleted,
    required this.client,
    required this.applications,
    required this.canApply,
    required this.version,
    this.acceptedFreelancer,
  });

  factory PostedJob.fromJson(Map<String, dynamic> json) {
    return PostedJob(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      budget: json['budget'],
      deadline: DateTime.parse(json['deadline']),
      skills: List<String>.from(json['skills']),
      location: json['location'],
      clientName: json['clientName'],
      isCompleted: json['isCompleted'],
      client: json['client'],
      applications: List<String>.from(json['applications']),
      canApply: json['canApply'],
      version: json['__v'],
      acceptedFreelancer: json['acceptedFreelancer'],
    );
  }
}