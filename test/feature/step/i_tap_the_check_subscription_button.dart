import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I tap the check subscription button
Future<void> iTapTheCheckSubscriptionButton(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key('checkSubscriptionButton')));
  await tester.pumpAndSettle();
}
