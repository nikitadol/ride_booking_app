import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

extension IterableLatLngExtension on Iterable<LatLng> {
  LatLngBounds computeBounds() {
    final firstLatLng = first;
    var s = firstLatLng.latitude;
    var n = firstLatLng.latitude;
    var w = firstLatLng.longitude;
    var e = firstLatLng.longitude;

    for (final position in this) {
      s = min(s, position.latitude);
      n = max(n, position.latitude);
      w = min(w, position.longitude);
      e = max(e, position.longitude);
    }
    return LatLngBounds(southwest: LatLng(s, w), northeast: LatLng(n, e));
  }
}
