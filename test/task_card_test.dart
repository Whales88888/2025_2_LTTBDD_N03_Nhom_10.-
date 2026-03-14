import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_planner/l10n/app_localizations.dart';
import 'package:study_planner/models/task.dart';
import 'package:study_planner/ui/theme/app_theme.dart';
import 'package:study_planner/ui/widgets/task_card.dart';

void main() {
  testWidgets('TaskCard handles very long task text without overflow', (
    WidgetTester tester,
  ) async {
    final DateTime now = DateTime(2026, 3, 14);
    final Task task = Task(
      id: 'long-text-task',
      title: List<String>.filled(40, 'VeryLongTaskTitle').join(),
      note: List<String>.filled(20, 'VeryLongTaskNote').join(' '),
      subject: List<String>.filled(60, 'VeryLongSubject').join(),
      date: now,
      startTime: const TimeOfDay(hour: 8, minute: 0),
      durationMinutes: 90,
      priority: 2,
      isDone: false,
      tags: const <String>[],
      createdAt: now,
      updatedAt: now,
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Center(
            child: SizedBox(width: 320, child: TaskCard(task: task)),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(TaskCard), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
