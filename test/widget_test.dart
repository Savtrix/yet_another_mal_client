
import 'package:flutter_test/flutter_test.dart';

import 'package:yet_another_mal_client/main.dart';


void main() {
  testWidgets('Login page loading', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    expect(find.text('LOGIN'), findsOneWidget);
  });
}
