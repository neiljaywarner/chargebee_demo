import 'package:flutter_test/flutter_test.dart';

/// Usage: I see a subscription status of "active"
Future<void> iSeeASubscriptionStatusOfActive(WidgetTester tester) async {
  expect(find.textContaining('Status: active'), findsOneWidget);
}
