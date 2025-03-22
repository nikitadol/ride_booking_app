import 'package:async/async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_booking_app/api/google/google_maps_api.dart';
import 'package:ride_booking_app/api/google/models/google_maps_response.dart';
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
    List<String> types = const ['geocode'],
  }) async {
    return _googleApiCall(
      () => _googleMapsApi.placeAutocomplete(
        input: input,
        language: language,
        types: types,
        sessionToken: sessionToken,
        apiKey: AppConstants.googleMapsApiKey,
      ),
      emptyBuilder: () => const [],
      mapper:
          (value) =>
              value.predictions
                  .map(
                    (e) => (
                      id: e.placeId,
                      description: e.description,
                      matchedSubstrings: e.matchedSubstrings,
                    ),
                  )
                  .toList(),
    );
  }

  Future<Result<({double lat, double lng})>> placeDetails({
    required String id,
    required String language,
    required String sessionToken,
  }) async {
    return _googleApiCall(
      () => _googleMapsApi.placeDetails(
        placeId: id,
        language: language,
        sessionToken: sessionToken,
        apiKey: AppConstants.googleMapsApiKey,
      ),
      mapper: (value) => value.result.geometry.location,
    );
  }

  Future<Result<T>> _googleApiCall<T, R extends GoogleMapsResponse>(
    Future<R> Function() call, {
    required T Function(R value) mapper,
    T Function()? emptyBuilder,
  }) async {
    try {
      final res = await call();

      return Result.value(switch (res.status) {
        'OK' => mapper(res),
        'ZERO_RESULTS' when emptyBuilder != null => emptyBuilder(),
        _ => throw Exception(res.status),
      });
    } catch (e, s) {
      return Result.error(e, s);
    }
  }
}
