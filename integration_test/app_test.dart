import 'package:chargebee_demo/constants/app_constants.dart';
import 'package:chargebee_demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('integration: happy path shows active', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: ChargebeeDemoApp()));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('subscriptionIdField')),
      AppConstants.defaultSubscriptionId,
    );
    await tester.tap(find.byKey(const Key('checkSubscriptionButton')));
    await tester.pumpAndSettle();

    expect(find.textContaining('Status: active'), findsOneWidget);
  });
}
