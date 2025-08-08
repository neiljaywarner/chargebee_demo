import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart';

import 'package:chargebee_demo/features/subscription/subscription.dart';

part 'subscription_repository.g.dart';

abstract class SubscriptionRepository {
  Future<Subscription> getSubscriptionById(String id);
}

class LocalMockSubscriptionRepository implements SubscriptionRepository {
  @override
  Future<Subscription> getSubscriptionById(String id) async {
if (id.trim().toLowerCase() == 'sub_demo_incorrect') {
      throw Exception('Subscription not found');
    }
    final jsonString = await rootBundle.loadString('assets/mock/subscription_active.json');
    final map = jsonDecode(jsonString) as Map<String, dynamic>;
    final sub = Subscription.fromJson(map['subscription'] as Map<String, dynamic>);
    return sub.copyWith(id: id);
  }
}

@riverpod
SubscriptionRepository subscriptionRepository(Ref ref) {
  return LocalMockSubscriptionRepository();
}
