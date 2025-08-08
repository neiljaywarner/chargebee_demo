import 'package:chargebee_demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Subscription mocked happy path', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: ChargebeeDemoApp()));
    await tester.enterText(find.byKey(const Key('subscriptionIdField')), 'sub_123456789');
    await tester.tap(find.byKey(const Key('checkSubscriptionButton')));
    await tester.pumpAndSettle();

    expect(find.textContaining('Status: active'), findsOneWidget);
  });
}
