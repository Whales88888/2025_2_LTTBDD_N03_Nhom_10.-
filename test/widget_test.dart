import 'package:study_planner/main.dart';
import 'package:study_planner/ui/screens/home_screen.dart';

void main() {
  testWidgets('App shows HomeScreen placeholder', (WidgetTester tester) async {
  testWidgets('App boots with AppShell and HomeScreen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const StudyPlannerApp());
    expect(find.byIcon(Icons.home_outlined), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.byType(HomeScreen), findsOneWidget);
  });