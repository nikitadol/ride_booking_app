import 'package:freezed_annotation/freezed_annotation.dart';

part 'google_place_autocomplete_prediction.freezed.dart';
part 'google_place_autocomplete_prediction.g.dart';

@Freezed(fromJson: true, toJson: false)
abstract class GooglePlaceAutocompletePrediction
    with _$GooglePlaceAutocompletePrediction {
  factory GooglePlaceAutocompletePrediction({
    required String description,
    required List<({int length, int offset})> matchedSubstrings,
    required String placeId,
  }) = _GooglePlaceAutocompletePrediction;

  factory GooglePlaceAutocompletePrediction.fromJson(
    Map<String, Object?> json,
  ) => _$GooglePlaceAutocompletePredictionFromJson(json);
}
