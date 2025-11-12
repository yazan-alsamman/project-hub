class TaskModel {
  final String title;
  final String subtitle;
  final String category;
  final String priority;
  final String dueDate;
  final String assigneeName;
  final String assigneeInitials;
  final String status; // 'All', 'In Progress', 'Completed', 'Pending'
  final String priorityColor;
  final String avatarColor;

  TaskModel({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.priority,
    required this.dueDate,
    required this.assigneeName,
    required this.assigneeInitials,
    required this.status,
    required this.priorityColor,
    required this.avatarColor,
  });
}
