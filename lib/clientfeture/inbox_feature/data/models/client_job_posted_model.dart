class ClientJobPosted {
  final String id;
  final String title;
  final String description;
  final int budget;
  final DateTime deadline;
  final String clientName;
  final List<String> skills;
  final String location;

  ClientJobPosted({
    required this.id,
    required this.title,
    required this.description,
    required this.budget,
    required this.deadline,
    required this.clientName,
    required this.skills,
    required this.location,
  });

  factory ClientJobPosted.fromJson(Map<String, dynamic> json) {
    return ClientJobPosted(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      budget: json['budget'],
      deadline: DateTime.parse(json['deadline']),
      clientName: json['clientName'],
      skills: List<String>.from(json['skills']),
      location: json['location'],
    );
  }
}