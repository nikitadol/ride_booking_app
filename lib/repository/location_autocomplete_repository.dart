import 'package:async/async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_booking_app/api/google/google_maps_api.dart';
import 'package:ride_booking_app/constants/constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_autocomplete_repository.g.dart';

@riverpod
LocationAutocompleteRepository locationAutocompleteRepository(Ref ref) {
  return LocationAutocompleteRepository(
    googleMapsApi: ref.watch(googleMapsApiProvider),
  );
}

typedef AutocompleteItem =
    ({
      String description,
      List<({int length, int offset})> matchedSubstrings,
      String id,
    });

class LocationAutocompleteRepository {
  final GoogleMapsApi _googleMapsApi;

  LocationAutocompleteRepository({required GoogleMapsApi googleMapsApi})
    : _googleMapsApi = googleMapsApi;

  Future<Result<List<AutocompleteItem>>> autocomplete({
    required String input,
    required String language,
    required String sessionToken,
  }) async {
    try {
      final results = await _googleMapsApi.placeAutocomplete(
        input: input,
        language: language,
        types: const ['geocode'],
        sessionToken: sessionToken,
        apiKey: AppConstants.googleMapsApiKey,
      );

      if (results.status == 'OK') {
        return Result.value(
          results.predictions
              .map(
                (e) => (
                  id: e.placeId,
                  description: e.description,
                  matchedSubstrings: e.matchedSubstrings,
                ),
              )
              .toList(),
        );
      } else {
        throw Exception(results.status);
      }
    } catch (e, s) {
      return Result.error(e, s);
    }
  }
}
