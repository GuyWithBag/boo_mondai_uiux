import 'package:flutter_test/flutter_test.dart';

import 'package:react_to_flutter/main.dart';

void main() {
  testWidgets('Creator Studio renders the converted shell', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BooMondaiApp());

    expect(find.text('BooMondai Flutter'), findsOneWidget);

    await tester.tap(find.text('Open').first);
    await tester.pumpAndSettle();

    expect(find.text('JLPT N5 Grammar'), findsOneWidget);
    expect(find.text('Flashcard'), findsOneWidget);
    expect(find.text('Save & Close'), findsOneWidget);

    await tester.tap(find.text('Multiple Choice'));
    await tester.pumpAndSettle();

    expect(find.text('ANSWER OPTIONS'), findsOneWidget);
    expect(find.text('Add Option'), findsOneWidget);
  });
}
