import 'package:chargebee_demo/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I am on the subscription screen
Future<void> iAmOnTheSubscriptionScreen(WidgetTester tester) async {
  await tester.pumpWidget(const ProviderScope(child: ChargebeeDemoApp()));
  await tester.pumpAndSettle();
}
