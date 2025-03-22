import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_booking_app/common/provider/autocomplete_session_token_provider.dart';
import 'package:ride_booking_app/component/main_map_component.dart';
import 'package:ride_booking_app/constants/constants.dart';
import 'package:ride_booking_app/repository/location_autocomplete_repository.dart';
import 'package:ride_booking_app/screen/choose_location_screen/choose_location_screen.dart';
import 'package:ride_booking_app/widget/bottom_gap.dart';
import 'package:ride_booking_app/widget/self_sized_bottom_sheet.dart';
import 'package:ride_booking_app/widget/status_bar_dimmer.dart';
import 'package:ride_booking_app/widget/text_field_button.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_screen.g.dart';
part 'provider/date_provider.dart';
part 'provider/is_form_valid_provider.dart';
part 'provider/passengers_provider.dart';
part 'provider/point_provider.dart';
part 'provider/time_provider.dart';
part 'sub/bottom_sheet_content.dart';
part 'sub/date_picker.dart';
part 'sub/maps.dart';
part 'sub/passengers_picker.dart';
part 'sub/process_button.dart';
part 'sub/time_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    // TODO(nikitadol): may need show once?
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ScaffoldFeatureController<MaterialBanner, MaterialBannerClosedReason>?
      controller;

      void close() {
        controller?.close();
      }

      controller = ScaffoldMessenger.of(
        _scaffoldKey.currentContext!,
      ).showMaterialBanner(
        MaterialBanner(
          content: const Text('You can select points directly on map'),
          actions: [TextButton(onPressed: close, child: const Text('Ok'))],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StatusBarDimmer.from(context),
      key: _scaffoldKey,
      body: const _Maps(),
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const SelfSizedBottomSheet(
        child: _BottomSheetContent(),
      ),
    );
  }
}
