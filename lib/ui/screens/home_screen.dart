import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_planner/provider/task_provider.dart';
import 'package:study_planner/ui/widgets/task_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskProvider taskProvider = context.watch<TaskProvider>();
    final tasks = taskProvider.tasksByDate(taskProvider.selectedDate);

    return Scaffold(
      body: SafeArea(
        child: tasks.isEmpty
            ? const Center(child: Icon(Icons.event_note_outlined, size: 48))
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: tasks.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 8),
                itemBuilder: (BuildContext context, int index) =>
                    TaskCard(task: tasks[index]),
              ),
      ),
    );
  }
}
