import 'package:flutter/material.dart';
import 'package:study_planner/ui/screens/app_shell.dart';
import 'package:study_planner/ui/theme/app_theme.dart';

void main() {
  runApp(const StudyPlannerApp());
}

class StudyPlannerApp extends StatelessWidget {
  const StudyPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Study Planner',
      theme: AppTheme.light,
      home: const AppShell(),
    );
  }
}
