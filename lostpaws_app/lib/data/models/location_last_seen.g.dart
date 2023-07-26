// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_last_seen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LocationLastSeen _$$_LocationLastSeenFromJson(Map<String, dynamic> json) =>
    _$_LocationLastSeen(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      street: json['street'] as String,
      city: json['city'] as String,
      regionalDistrict: json['regionalDistrict'] as String,
      province: json['province'] as String,
      country: json['country'] as String,
      postalCode: json['postalCode'] as String,
    );

Map<String, dynamic> _$$_LocationLastSeenToJson(_$_LocationLastSeen instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'street': instance.street,
      'city': instance.city,
      'regionalDistrict': instance.regionalDistrict,
      'province': instance.province,
      'country': instance.country,
      'postalCode': instance.postalCode,
    };
