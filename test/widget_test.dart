import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_planner/main.dart';
import 'package:study_planner/ui/screens/home_screen.dart';

void main() {
  testWidgets('App boots with AppShell and HomeScreen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const StudyPlannerApp());
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
