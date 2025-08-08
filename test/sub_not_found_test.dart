import 'package:chargebee_demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows user-friendly message when subscription not found', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: ChargebeeDemoApp()));
    await tester.pumpAndSettle();

await tester.enterText(find.byKey(const Key('subscriptionIdField')), 'sub_demo_incorrect');
    await tester.tap(find.byKey(const Key('checkSubscriptionButton')));
    await tester.pumpAndSettle();

    expect(find.text('Subscription not found'), findsOneWidget);
  });
}
