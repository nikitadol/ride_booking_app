import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_booking_app/constants/constants.dart';

class MainMapComponent extends StatefulWidget {
  const MainMapComponent({super.key, this.markers = const {}, this.onTap});

  final void Function(LatLng mapCoordinate)? onTap;
  final Set<Marker> markers;

  static Marker buildMarker({
    required String id,
    required LatLng position,
    required double iconColor,
    double zIndex = 0.0,
    VoidCallback? onTap,
  }) {
    return Marker(
      markerId: MarkerId(id),
      position: position,
      icon: BitmapDescriptor.defaultMarkerWithHue(iconColor),
      onTap: onTap,
      zIndex: zIndex,
    );
  }

  @override
  State<MainMapComponent> createState() => _MainMapComponentState();
}

class _MainMapComponentState extends State<MainMapComponent> {
  late GoogleMapController controller;

  @override
  void didUpdateWidget(covariant MainMapComponent oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.markers.isNotEmpty) {
      final bounds = _computeBounds(widget.markers.map((e) => e.position));

      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 32));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      padding: MediaQuery.paddingOf(context),
      initialCameraPosition: AppConstants.alpsCenterPosition,
      myLocationButtonEnabled: false,
      tiltGesturesEnabled: false,
      compassEnabled: false,
      rotateGesturesEnabled: false,
      mapType: MapType.terrain,
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      markers: widget.markers,
      onTap: widget.onTap,
      onMapCreated: (controller) async {
        this.controller = controller;

        await controller.animateCamera(AppConstants.alpsCameraUpdate);
      },
    );
  }
}

LatLngBounds _computeBounds(Iterable<LatLng> positions) {
  final firstLatLng = positions.first;
  var s = firstLatLng.latitude;
  var n = firstLatLng.latitude;
  var w = firstLatLng.longitude;
  var e = firstLatLng.longitude;

  for (final position in positions) {
    s = min(s, position.latitude);
    n = max(n, position.latitude);
    w = min(w, position.longitude);
    e = max(e, position.longitude);
  }
  return LatLngBounds(southwest: LatLng(s, w), northeast: LatLng(n, e));
}
