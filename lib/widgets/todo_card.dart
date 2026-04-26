// lib/widgets/todo_card.dart
// Owner: shared (do not edit without telling the team)

import 'package:flutter/material.dart';
import '../models/task.dart';

class TodoCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback? onDelete;

  const TodoCard({
    super.key,
    required this.task,
    required this.onToggle,
    this.onDelete,
  });

  Color _categoryColor(TaskCategory cat) {
    switch (cat) {
      case TaskCategory.work:
        return const Color(0xFF6C63FF);
      case TaskCategory.study:
        return const Color(0xFF1D9E75);
      case TaskCategory.personal:
        return const Color(0xFFD4537E);
      case TaskCategory.urgent:
        return const Color(0xFFE24B4A);
    }
  }

  String _categoryLabel(TaskCategory cat) {
    switch (cat) {
      case TaskCategory.work:
        return 'work';
      case TaskCategory.study:
        return 'study';
      case TaskCategory.personal:
        return 'personal';
      case TaskCategory.urgent:
        return 'urgent';
    }
  }

  Color _statusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.done:
        return const Color(0xFF1D9E75);
      case TaskStatus.inProgress:
        return const Color(0xFFBA7517);
      case TaskStatus.todo:
        return const Color(0xFF888780);
      case TaskStatus.urgent:

        throw UnimplementedError();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color catColor = _categoryColor(task.category);
    final bool done = task.isDone;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: done ? const Color(0xFFE0E0E0) : catColor.withOpacity(0.25),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onToggle,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                // Checkbox circle
                GestureDetector(
                  onTap: onToggle,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: done ? catColor : Colors.transparent,
                      border: Border.all(
                        color: done ? catColor : const Color(0xFFD3D1C7),
                        width: 1.5,
                      ),
                    ),
                    child: done
                        ? const Icon(Icons.check, size: 13, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(width: 12),

                // Title + status
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: done
                              ? const Color(0xFFB4B2A9)
                              : const Color(0xFF2C2C2A),
                          decoration:
                          done ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      if (task.description != null && !done) ...[
                        const SizedBox(height: 2),
                        Text(
                          task.description!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF888780),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Category badge
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: catColor.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    _categoryLabel(task.category),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: catColor,
                    ),
                  ),
                ),

                // Delete button
                if (onDelete != null) ...[
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: onDelete,
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}