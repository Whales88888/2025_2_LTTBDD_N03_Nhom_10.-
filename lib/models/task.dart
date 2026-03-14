import 'package:flutter/material.dart';

class Task {
  const Task({
    required this.id,
    required this.title,
    required this.date,
    required this.startTime,
    required this.durationMinutes,
    required this.priority,
    required this.isDone,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    this.note,
    this.subject,
  });

  final String id;
  final String title;
  final String? note;
  final DateTime date;
  final TimeOfDay startTime;
  final int durationMinutes;
  final int priority;
  final bool isDone;
  final String? subject;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  Task copyWith({
    String? id,
    String? title,
    String? note,
    DateTime? date,
    TimeOfDay? startTime,
    int? durationMinutes,
    int? priority,
    bool? isDone,
    String? subject,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      priority: priority ?? this.priority,
      isDone: isDone ?? this.isDone,
      subject: subject ?? this.subject,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
