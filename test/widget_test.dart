import 'package:flutter_test/flutter_test.dart';
import 'package:tasks/main.dart';

void main() {
  testWidgets('Registration screen renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const Lab6App());

    // Verify that Registration screen title and submit button are present.
    expect(find.text('Create Account'), findsOneWidget);
    expect(find.text('Register Now'), findsOneWidget);
  });
}
