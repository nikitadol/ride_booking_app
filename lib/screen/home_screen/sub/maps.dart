part of '../home_screen.dart';

class _Maps extends ConsumerWidget {
  const _Maps();

  static Marker _buildMarker(PointType pointType, LatLng position) {
    return MainMapComponent.buildMarker(
      id: pointType.name,
      position: position,
      iconColor: switch (pointType) {
        PointType.pickUp => BitmapDescriptor.hueYellow,
        PointType.dropOff => BitmapDescriptor.hueRed,
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickUpPoint = ref.watch(_pointProvider(PointType.pickUp))?.position;
    final dropOffPoint = ref.watch(_pointProvider(PointType.dropOff))?.position;

    return MainMapComponent(
      onTap: (position) {
        VoidCallback select(PointType pointType) {
          return () {
            ref.read(_pointProvider(pointType).notifier).newPosition(position);
            Navigator.pop(context);
          };
        }

        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Use point...'),
                actions: [
                  TextButton(
                    onPressed: select(PointType.pickUp),
                    child: const Text('As pick-up'),
                  ),
                  TextButton(
                    onPressed: select(PointType.dropOff),
                    child: const Text('As drop-off'),
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
