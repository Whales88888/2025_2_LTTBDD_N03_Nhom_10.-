import 'package:flutter/material.dart';
import 'package:study_planner/models/task.dart';

class TaskProvider extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  final List<Task> _tasks = <Task>[];

  DateTime get selectedDate => _selectedDate;

  List<Task> get tasks => List<Task>.unmodifiable(_tasks);

  void setSelectedDate(DateTime value) {
    _selectedDate = DateTime(value.year, value.month, value.day);
    notifyListeners();
  }

  List<Task> tasksByDate(DateTime date) {
    return _tasks.where((task) => _isSameDate(task.date, date)).toList();
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
