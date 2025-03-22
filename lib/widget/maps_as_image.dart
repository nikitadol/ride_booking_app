import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsAsImage extends StatelessWidget {
  const MapsAsImage({super.key, required this.bounds, this.markers = const {}});

  final LatLngBounds bounds;
  final Set<Marker> markers;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: GoogleMap(
        initialCameraPosition: CameraPosition(target: bounds.northeast),
        liteModeEnabled: !true,
        mapType: MapType.terrain,
        mapToolbarEnabled: false,
        zoomControlsEnabled: false,
        markers: markers,
        onMapCreated: (controller) {
          controller.moveCamera(CameraUpdate.newLatLngBounds(bounds, 24));
        },
      ),
    );
  }
}
