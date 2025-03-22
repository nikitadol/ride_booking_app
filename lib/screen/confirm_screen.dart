import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_booking_app/common/extensions/google_maps_extensions.dart';
import 'package:ride_booking_app/localization/app_localizations.dart';
import 'package:ride_booking_app/screen/home_screen/home_screen.dart';
import 'package:ride_booking_app/widget/maps_as_image.dart';

class ConfirmScreen extends ConsumerWidget {
  const ConfirmScreen({super.key});

  static Marker _buildMarker(PointType pointType, LatLng position) {
    return Marker(
      markerId: MarkerId(pointType.name),
      position: position,
      icon: BitmapDescriptor.defaultMarkerWithHue(switch (pointType) {
        PointType.pickUp => BitmapDescriptor.hueYellow,
        PointType.dropOff => BitmapDescriptor.hueRed,
      }),
      onTap: null,
      zIndex: 0.0,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final materialLocalizations = MaterialLocalizations.of(context);

    final pickUp = ref.watch(pointProvider(PointType.pickUp));
    if (pickUp == null) {
      return const Scaffold();
    }

    final dropOff = ref.watch(pointProvider(PointType.dropOff))!;
    final passengers = ref.watch(passengersProvider)!;
    final date = ref.watch(dateProvider)!;
    final time = ref.watch(timeProvider)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.confirmRideTitle)),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: MapsAsImage(
              bounds: [pickUp.position!, dropOff.position!].computeBounds(),
              markers: {
                _buildMarker(PointType.pickUp, pickUp.position!),
                _buildMarker(PointType.dropOff, dropOff.position!),
              },
            ),
          ),
          ListTile(title: Text(localizations.passangers(passengers))),
          ListTile(title: Text(materialLocalizations.formatFullDate(date))),
          ListTile(title: Text(time.format(context))),
          Center(
            child: FilledButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder:
                      (context) =>
                          AlertDialog(title: Text(localizations.booked)),
                );
                if (context.mounted) {
                  Navigator.of(context).pop();
                  ref.invalidate(pointProvider(PointType.pickUp));
                  ref.invalidate(pointProvider(PointType.dropOff));
                  ref.invalidate(passengersProvider);
                  ref.invalidate(dateProvider);
                  ref.invalidate(timeProvider);
                }
              },
              child: Text(localizations.confirm),
            ),
          ),
        ],
      ),
    );
  }
}
