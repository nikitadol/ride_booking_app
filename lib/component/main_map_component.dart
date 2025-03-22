import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_booking_app/common/extensions/google_maps_extensions.dart';
import 'package:ride_booking_app/constants/constants.dart';

class MainMapComponent extends StatefulWidget {
  const MainMapComponent({super.key, this.markers = const {}, this.onTap});

  final void Function(LatLng mapCoordinate)? onTap;
  final Set<Marker> markers;

  @override
  State<MainMapComponent> createState() => _MainMapComponentState();
}

class _MainMapComponentState extends State<MainMapComponent> {
  late GoogleMapController controller;

  @override
  void didUpdateWidget(covariant MainMapComponent oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.markers.isNotEmpty) {
      final bounds = widget.markers.map((e) => e.position).computeBounds();

      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 32));
    } else {
      if (oldWidget.markers.isNotEmpty) {
        controller.animateCamera(AppConstants.alpsCameraUpdate);
      }
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
