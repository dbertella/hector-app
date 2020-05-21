// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:hector_app/main.dart';

void main() {
  testWidgets('Home page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(StoryApp());

    // Press the button in home page
    await tester.tap(find.text('Read the story'));
    await tester.pump();

    // Verify that the page has changed.
    expect(find.text('Read the story'), findsNothing);
    expect(find.text('Hector the little dinosaur'), findsOneWidget);
  });
}
