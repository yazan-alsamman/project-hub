class ProjectModel {
  final String id;
  final String title;
  final String company;
  final String description;
  final double progress;
  final String startDate;
  final String endDate;
  final int teamMembers;
  final String status;

  ProjectModel({
    required this.id,
    required this.title,
    required this.company,
    required this.description,
    required this.progress,
    required this.startDate,
    required this.endDate,
    required this.teamMembers,
    required this.status,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      title: json['title'],
      company: json['company'],
      description: json['description'],
      progress: json['progress'].toDouble(),
      startDate: json['startDate'],
      endDate: json['endDate'],
      teamMembers: json['teamMembers'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'description': description,
      'progress': progress,
      'startDate': startDate,
      'endDate': endDate,
      'teamMembers': teamMembers,
      'status': status,
    };
  }
}
