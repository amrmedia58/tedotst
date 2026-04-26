// lib/models/task.dart
// Owner: shared (do not edit without telling the team)

enum TaskStatus { todo, inProgress, done, urgent }

enum TaskCategory { work, study, personal, urgent }

class Task {
  final String id;
  final String title;
  final String? description;
  TaskStatus status;
  final TaskCategory category;
  final DateTime createdAt;
  final String assignedTo;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.status = TaskStatus.todo,
    required this.category,
    required this.assignedTo,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  bool get isDone => status == TaskStatus.done;

  void toggleDone() {
    if (status == TaskStatus.done) {
      status = TaskStatus.todo;
    } else {
      status = TaskStatus.done;
    }
  }
}