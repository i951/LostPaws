import 'package:freezed_annotation/freezed_annotation.dart';
part 'location_last_seen.freezed.dart';
part 'location_last_seen.g.dart';

@freezed
class LocationLastSeen with _$LocationLastSeen {
  LocationLastSeen._();

  factory LocationLastSeen({
    @JsonKey(name: 'latitude') required double latitude,
    @JsonKey(name: 'longitude') required double longitude,
    @JsonKey(name: 'street') required String street,
    @JsonKey(name: 'city') required String city,
    @JsonKey(name: 'regionalDistrict') required String regionalDistrict,
    @JsonKey(name: 'province') required String province,
    @JsonKey(name: 'country') required String country,
    @JsonKey(name: 'postalCode') required String postalCode,
  }) = _LocationLastSeen;

  factory LocationLastSeen.fromJson(Map<String, dynamic> json) =>
      _$LocationLastSeenFromJson(json);
}
