import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I enter the subscription id "sub_123456789"
Future<void> iEnterTheSubscriptionIdSub123456789(WidgetTester tester) async {
  await tester.enterText(
    find.byKey(const Key('subscriptionIdField')),
    'sub_123456789',
  );
  await tester.pumpAndSettle();
}
