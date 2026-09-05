import 'package:flutter_test/flutter_test.dart';

import 'package:code_alpha_quote_app/main.dart';
import 'package:code_alpha_quote_app/screens/home_screen.dart';

void main() {
  testWidgets('App shows a quote and the New Quote button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const QuoteApp());

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('New Quote'), findsOneWidget);
    expect(find.textContaining('“'), findsOneWidget);
  });
}