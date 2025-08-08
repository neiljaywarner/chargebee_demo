import 'dart:io';
import 'dart:ui' as ui;

import 'package:chargebee_demo/constants/app_constants.dart';
import 'package:chargebee_demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _capture(WidgetTester tester, String filePath) async {
  final boundary = tester.renderObject(find.byKey(const Key('rootBoundary'))) as RenderRepaintBoundary;
  final image = await boundary.toImage(pixelRatio: 2.0);
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  final bytes = byteData!.buffer.asUint8List();
  final file = File(filePath);
  await file.create(recursive: true);
  await file.writeAsBytes(bytes);
}

void main() {
  testWidgets('patrol-style widget test: happy path shows active', (tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
    tester.binding.window.devicePixelRatioTestValue = 2.0;

    await tester.pumpWidget(
      const RepaintBoundary(
        key: Key('rootBoundary'),
        child: ProviderScope(child: ChargebeeDemoApp()),
      ),
    );

    await tester.enterText(find.byKey(const Key('subscriptionIdField')), AppConstants.defaultSubscriptionId);
    await tester.tap(find.byKey(const Key('checkSubscriptionButton')));
    await tester.pumpAndSettle();

    expect(find.textContaining('Status: active'), findsOneWidget);

    await _capture(tester, 'artifacts/screenshots/commit1_proof.png');

    addTearDown(() {
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });
  });
}
