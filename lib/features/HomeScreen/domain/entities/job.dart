class Job {
  final String id;
  final String title;
  final String description;
  final double budget;
  final DateTime deadline;
  final String clientName;
  final String client;
  final List<String> applications;
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
}