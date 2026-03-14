import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_planner/models/task.dart';
import 'package:study_planner/provider/task_provider.dart';
import 'package:study_planner/services/local_storage_service.dart';
import 'package:study_planner/services/task_serializer.dart';

class _FakeLocalStorageService extends LocalStorageService {
  _FakeLocalStorageService({String? initialTasksJson}) {
    if (initialTasksJson != null) {
      _storage['tasks_json'] = initialTasksJson;
    }
  }

  final Map<String, String> _storage = <String, String>{};

  @override
  Future<String?> getString(String key) async => _storage[key];

  @override
  Future<void> setString(String key, String value) async {
    _storage[key] = value;
  }

  @override
  Future<void> remove(String key) async {
    _storage.remove(key);
  }
}

Task _buildTask({
  required String id,
  required DateTime date,
  required TimeOfDay startTime,
  required int durationMinutes,
}) {
  return Task(
    id: id,
    title: 'Task $id',
    date: date,
    startTime: startTime,
    durationMinutes: durationMinutes,
    priority: 2,
    isDone: false,
    tags: const <String>[],
    createdAt: date,
    updatedAt: date,
  );
}

void main() {
  group('TaskProvider.findOverlappingTask', () {
    final DateTime date = DateTime(2026, 3, 14);
    final Task existingTask = _buildTask(
      id: 'task-1',
      date: date,
      startTime: const TimeOfDay(hour: 21, minute: 0),
      durationMinutes: 60,
    );

    late TaskProvider provider;

    setUp(() async {
      provider = TaskProvider(
        localStorageService: _FakeLocalStorageService(
          initialTasksJson: TaskSerializer.encode(<Task>[existingTask]),
        ),
      );
      await provider.load();
    });

    test('returns the conflicting task when ranges overlap', () {
      final Task? overlappingTask = provider.findOverlappingTask(
        date: date,
        startTime: const TimeOfDay(hour: 21, minute: 30),
        durationMinutes: 30,
      );

      expect(overlappingTask?.id, existingTask.id);
    });

    test('allows tasks that start exactly when another task ends', () {
      final Task? overlappingTask = provider.findOverlappingTask(
        date: date,
        startTime: const TimeOfDay(hour: 22, minute: 0),
        durationMinutes: 30,
      );

      expect(overlappingTask, isNull);
    });

    test('ignores the current task when editing', () {
      final Task? overlappingTask = provider.findOverlappingTask(
        date: date,
        startTime: const TimeOfDay(hour: 21, minute: 0),
        durationMinutes: 60,
        excludeTaskId: existingTask.id,
      );

      expect(overlappingTask, isNull);
    });

    test(
      'detects overlaps when an existing task extends past midnight',
      () async {
        final Task overnightTask = _buildTask(
          id: 'task-overnight',
          date: DateTime(2026, 3, 13),
          startTime: const TimeOfDay(hour: 23, minute: 30),
          durationMinutes: 90,
        );
        provider = TaskProvider(
          localStorageService: _FakeLocalStorageService(
            initialTasksJson: TaskSerializer.encode(<Task>[overnightTask]),
          ),
        );
        await provider.load();

        final Task? overlappingTask = provider.findOverlappingTask(
          date: DateTime(2026, 3, 14),
          startTime: const TimeOfDay(hour: 0, minute: 15),
          durationMinutes: 30,
        );

        expect(overlappingTask?.id, overnightTask.id);
      },
    );
  });
}
