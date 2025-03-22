import 'package:freezed_annotation/freezed_annotation.dart';

part 'google_place_details.g.dart';
part 'google_place_details.freezed.dart';

@Freezed(fromJson: true, toJson: false)
abstract class GooglePlaceDetails with _$GooglePlaceDetails {
  factory GooglePlaceDetails({
    required ({({double lat, double lng}) location}) geometry,
  }) = _GooglePlaceDetails;

  factory GooglePlaceDetails.fromJson(Map<String, Object?> json) =>
      _$GooglePlaceDetailsFromJson(json);
}
