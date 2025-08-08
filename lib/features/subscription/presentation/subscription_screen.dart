import 'package:chargebee_demo/constants/app_constants.dart';
import 'package:chargebee_demo/features/subscription/subscription_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubscriptionScreen extends ConsumerStatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  ConsumerState<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends ConsumerState<SubscriptionScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: AppConstants.defaultSubscriptionId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(subscriptionControllerProvider.notifier).checkSubscription(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(subscriptionControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Chargebee Subscription Check')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              key: const Key('subscriptionIdField'),
              decoration: const InputDecoration(
                labelText: 'Subscription ID',
                hintText: 'e.g. sub_XXXX',
              ),
              controller: _controller,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(
                  key: const Key('resetButton'),
                  onPressed: () => ref.read(subscriptionControllerProvider.notifier).reset(),
                  child: const Text('Reset'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  key: const Key('checkSubscriptionButton'),
                  onPressed: () => ref.read(subscriptionControllerProvider.notifier).checkSubscription(_controller.text),
                  child: const Text('Check Subscription'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            switch (state) {
              AsyncData(:final value) when value != null => Card(
                child: ListTile(
                  title: Text('Status: ${value.status}'),
                  subtitle: Text('Customer: ${value.customerId}'),
                  trailing: const Icon(Icons.verified, semanticLabel: 'subscription-status'),
                ),
              ),
              AsyncError(:final error) => Text(
                (error.toString().toLowerCase().contains('not found'))
                    ? 'Subscription not found'
                    : 'Error: $error',
              ),
              AsyncLoading() => const Center(child: CircularProgressIndicator()),
              _ => const Text('Enter a subscription ID and press Check'),
            },
          ],
        ),
      ),
    );
  }
}

