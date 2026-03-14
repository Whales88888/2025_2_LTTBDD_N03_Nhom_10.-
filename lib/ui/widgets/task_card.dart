import 'package:flutter/material.dart';
import 'package:study_planner/models/task.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task, this.onTap});

  final Task task;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(task.title),
        subtitle: task.subject == null ? null : Text(task.subject!),
        trailing: Icon(
          task.isDone ? Icons.check_circle : Icons.radio_button_unchecked,
        ),
      ),
    );
  }
}
