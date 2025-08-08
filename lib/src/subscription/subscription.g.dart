// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubscriptionImpl _$$SubscriptionImplFromJson(Map<String, dynamic> json) =>
    _$SubscriptionImpl(
      id: json['id'] as String,
      status: json['status'] as String,
      customerId: json['customer_id'] as String,
      currentTermEnd: json['current_term_end'] == null
          ? null
          : DateTime.parse(json['current_term_end'] as String),
    );

Map<String, dynamic> _$$SubscriptionImplToJson(_$SubscriptionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'customer_id': instance.customerId,
      'current_term_end': instance.currentTermEnd?.toIso8601String(),
    };
