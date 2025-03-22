import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// values from https://en.wikipedia.org/wiki/Module:Location_map/data/Alps
const _alpsCenterPosition = CameraPosition(
  target: LatLng(45.625, 10.75),
  zoom: 6,
);

final _alpsCameraUpdate = CameraUpdate.newLatLngBounds(
  LatLngBounds(
    southwest: const LatLng(42.75, 4.5),
    northeast: const LatLng(48.5, 17),
  ),
  16,
);

class MainMapComponent extends StatefulWidget {
  const MainMapComponent({super.key, this.markers = const {}, this.onTap});

  final void Function(LatLng mapCoordinate)? onTap;
  final Set<Marker> markers;

  static Marker buildMarker({
    required String id,
    required LatLng position,
    required double iconColor,
    VoidCallback? onTap,
  }) {
    return Marker(
      markerId: MarkerId(id),
      position: position,
      icon: BitmapDescriptor.defaultMarkerWithHue(iconColor),
      onTap: onTap,
    );
  }

  @override
  State<MainMapComponent> createState() => _MainMapComponentState();
}

class _MainMapComponentState extends State<MainMapComponent> {
  late GoogleMapController controller;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      padding: MediaQuery.paddingOf(context),
      initialCameraPosition: _alpsCenterPosition,
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

        await controller.animateCamera(_alpsCameraUpdate);
      },
    );
  }
}
