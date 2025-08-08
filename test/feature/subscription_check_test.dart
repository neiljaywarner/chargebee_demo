// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/i_am_on_the_subscription_screen.dart';
import './step/i_enter_the_subscription_id_sub123456789.dart';
import './step/i_tap_the_check_subscription_button.dart';
import './step/i_see_a_subscription_status_of_active.dart';

void main() {
  group('''Verify active Chargebee subscription''', () {
    testWidgets('''Check an active subscription by ID''', (tester) async {
      await iAmOnTheSubscriptionScreen(tester);
      await iEnterTheSubscriptionIdSub123456789(tester);
      await iTapTheCheckSubscriptionButton(tester);
      await iSeeASubscriptionStatusOfActive(tester);
    });
  });
}
