import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_booking_app/component/main_map_component.dart';
import 'package:ride_booking_app/constants/constants.dart';
import 'package:ride_booking_app/screen/choose_location_screen/choose_location_screen.dart';
import 'package:ride_booking_app/widget/bottom_gap.dart';
import 'package:ride_booking_app/widget/self_sized_bottom_sheet.dart';
import 'package:ride_booking_app/widget/text_field_button.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_screen.g.dart';
part 'provider/temp_point_provider.dart';
part 'sub/bottom_sheet_content.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempPoint = ref.watch(tempPointProvider);

    return Scaffold(
      body: MainMapComponent(
        onTap: (position) {
          ref.read(tempPointProvider.notifier).changePosition(position);
        },
        markers: {
          if (tempPoint != null)
            MainMapComponent.buildMarker(
              id: 'temp_point',
              position: tempPoint,
              iconColor: 0,
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text('Use point...'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('As pick-up'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('As drop-off'),
                          ),
                        ],
                      ),
                );
              },
            ),
        },
      ),
      extendBody: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const SelfSizedBottomSheet(
        child: _BottomSheetContent(),
      ),
    );
  }
}
