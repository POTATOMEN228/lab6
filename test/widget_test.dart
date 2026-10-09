import 'package:flutter_test/flutter_test.dart';
import 'package:tasks/main.dart';

void main() {
  testWidgets('ProductDetailScreen renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that product details text is present.
    expect(find.text('Premium Wireless Headset'), findsOneWidget);
  });
}
