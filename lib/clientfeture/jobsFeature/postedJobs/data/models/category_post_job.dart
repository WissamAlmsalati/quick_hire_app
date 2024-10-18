class CategoryPostJob {
  final String id;
  final String name;

  CategoryPostJob({required this.id, required this.name});

  factory CategoryPostJob.fromJson(Map<String, dynamic> json) {
    return CategoryPostJob(
      id: json['_id'],
      name: json['name'],
    );
  }
}