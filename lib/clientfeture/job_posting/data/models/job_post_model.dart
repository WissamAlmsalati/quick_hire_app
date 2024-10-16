class PostJobModel {
  final String clientId;
  final String title;
  final String description;
  final int budget;
  final String deadline;
  final List<String> skills;
  final String categoryId;
  final String location; // Add this field

  PostJobModel({
    required this.clientId,
    required this.title,
    required this.description,
    required this.budget,
    required this.deadline,
    required this.skills,
    required this.categoryId,
    required this.location, // Add this field
  });

  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'title': title,
      'description': description,
      'budget': budget,
      'deadline': deadline,
      'skills': skills,
      'categoryId': categoryId,
      'location': location, // Add this field
    };
  }
}