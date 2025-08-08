import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:chargebee_demo/core/logging/logger.dart';
import 'package:chargebee_demo/features/subscription/subscription.dart';
import 'package:chargebee_demo/features/subscription/subscription_repository.dart';

part 'subscription_controller.g.dart';

@riverpod
class SubscriptionController extends _$SubscriptionController {
  @override
  FutureOr<Subscription?> build() async {
    return null;
  }

  Future<void> checkSubscription(String id) async {
    Log.d('checkSubscription: $id');
    state = const AsyncLoading();
    final repo = ref.read(subscriptionRepositoryProvider);
    state = await AsyncValue.guard(() => repo.getSubscriptionById(id));
    state.when(
      data: (sub) => Log.d('checkSubscription success: ${sub?.status} for ${sub?.id}'),
      error: (e, st) => Log.e('checkSubscription error: $e', e, st),
      loading: () {},
    );
  }

  void reset() {
    Log.d('reset called');
    state = const AsyncData(null);
  }
}
