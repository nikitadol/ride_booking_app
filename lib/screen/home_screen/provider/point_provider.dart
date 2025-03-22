part of '../home_screen.dart';

enum PointType { pickUp, dropOff }

typedef PointData = ({String name, LatLng? position, String? id});

@riverpod
class _Point extends _$Point {
  @override
  PointData? build(PointType type) {
    return null;
  }

  void newPosition(LatLng position) {
    String format(double num) {
      return position.latitude.toStringAsPrecision(6);
    }

    state = (
      name: '${format(position.latitude)}, ${format(position.longitude)}',
      position: position,
      id: null,
    );
  }

  Future<void> newLocation(String id, String name) async {
    if (id == state?.id) {
      return;
    }

    state = (name: name, position: null, id: id);

    final sessionToken = ref.read(autocompleteSessionTokenProvider);
    final res = await ref
        .read(locationAutocompleteRepositoryProvider)
        .placeDetails(id: id, language: 'en', sessionToken: sessionToken);

    final position = res.asValue?.value;
    if (position != null) {
      state = (
        name: name,
        position: LatLng(position.lat, position.lng),
        id: id,
      );
    }
  }
}
