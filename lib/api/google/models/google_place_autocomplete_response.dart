
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ride_booking_app/api/google/models/google_place_autocomplete_prediction.dart';

part 'google_place_autocomplete_response.g.dart';
part 'google_place_autocomplete_response.freezed.dart';

@Freezed(fromJson: true, toJson: false)
abstract class GooglePlaceAutocompleteResponse
    with _$GooglePlaceAutocompleteResponse {
  factory GooglePlaceAutocompleteResponse({
    required List<GooglePlaceAutocompletePrediction> predictions,
    required String status,
  }) = _GooglePlaceAutocompleteResponse;

  factory GooglePlaceAutocompleteResponse.fromJson(Map<String, Object?> json) =>
      _$GooglePlaceAutocompleteResponseFromJson(json);
}
