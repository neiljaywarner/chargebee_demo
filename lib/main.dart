import 'package:chargebee_demo/features/subscription/presentation/subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(const ProviderScope(child: ChargebeeDemoApp()));

class ChargebeeDemoApp extends StatelessWidget {
  const ChargebeeDemoApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Chargebee Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const SubscriptionScreen(),
      );
}
