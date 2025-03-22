import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ride_booking_app/api/google/models/google_place_details.dart';

part 'google_place_details_response.freezed.dart';
part 'google_place_details_response.g.dart';

@Freezed(fromJson: true, toJson: false)
abstract class GooglePlaceDetailsResponse with _$GooglePlaceDetailsResponse {
  factory GooglePlaceDetailsResponse({required GooglePlaceDetails result}) =
      _GooglePlaceDetailsResponse;

  factory GooglePlaceDetailsResponse.fromJson(Map<String, Object?> json) =>
      _$GooglePlaceDetailsResponseFromJson(json);
}
