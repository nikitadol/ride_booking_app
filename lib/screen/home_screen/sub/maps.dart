part of '../home_screen.dart';

class _Maps extends ConsumerWidget {
  const _Maps();

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
    final pickUpPoint = ref.watch(pointProvider(PointType.pickUp))?.position;
    final dropOffPoint = ref.watch(pointProvider(PointType.dropOff))?.position;

    return MainMapComponent(
      onTap: (position) {
        VoidCallback select(PointType pointType) {
          return () {
            ref.read(pointProvider(pointType).notifier).newPosition(position);
            Navigator.pop(context);
          };
        }

        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text(localizations.usePoint),
                actions: [
                  TextButton(
                    onPressed: select(PointType.pickUp),
                    child: Text(localizations.asPickUp),
                  ),
                  TextButton(
                    onPressed: select(PointType.dropOff),
                    child: Text(localizations.asDropOff),
                  ),
                ],
              ),
        );
      },
      markers: {
        if (pickUpPoint != null) _buildMarker(PointType.pickUp, pickUpPoint),
        if (dropOffPoint != null) _buildMarker(PointType.dropOff, dropOffPoint),
      },
    );
  }
}
