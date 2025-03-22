import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:ride_booking_app/api/dio.dart';
import 'package:ride_booking_app/api/google/models/google_place_autocomplete_response.dart';
import 'package:ride_booking_app/api/google/models/google_place_details_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'google_maps_api.g.dart';

@riverpod
GoogleMapsApi googleMapsApi(Ref ref) {
  final dio = ref.watch(dioProvider);

  return GoogleMapsApi(dio);
}

@RestApi(baseUrl: 'https://maps.googleapis.com/maps/api/')
abstract class GoogleMapsApi {
  factory GoogleMapsApi(Dio dio) = _GoogleMapsApi;

  @GET('place/autocomplete/json')
  Future<GooglePlaceAutocompleteResponse> placeAutocomplete({
    @Query('input') required String input,
    @Query('language') required String language,
    @Query('types') required List<String> types,
    @Query('sessiontoken') required String sessionToken,
    @Query('key') required String apiKey,
  });

  @GET('place/details/json')
  Future<GooglePlaceDetailsResponse> placeDetails({
    @Query('place_id') required String placeId,
    @Query('language') required String language,
    @Query('fields') required String fields,
    @Query('sessiontoken') required String sessionToken,
    @Query('key') required String apiKey,
  });
}
