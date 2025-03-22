import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_booking_app/common/provider/autocomplete_session_token_provider.dart';
import 'package:ride_booking_app/common/provider/locale_provider.dart';
import 'package:ride_booking_app/component/error_component.dart';
import 'package:ride_booking_app/localization/app_localizations.dart';
import 'package:ride_booking_app/repository/location_autocomplete_repository.dart';
import 'package:ride_booking_app/utils/riverpod.dart';
import 'package:ride_booking_app/utils/text_span.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'choose_location_screen.g.dart';
part 'provider/autocomplete_by_term_provider.dart';
part 'sub/content.dart';

typedef ChooseLocationScreenResult = ({String id, String name});

class ChooseLocationScreen extends StatefulWidget {
  const ChooseLocationScreen({super.key, required this.title});

  static Future<ChooseLocationScreenResult?> show(
    BuildContext context, {
    required String title,
  }) {
    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      scrollControlDisabledMaxHeightRatio: 1,
      clipBehavior: Clip.antiAlias,
      builder: (context) {
        return ChooseLocationScreen(title: title);
      },
    );
  }

  final String title;

  @override
  State<ChooseLocationScreen> createState() => _ChooseLocationScreenState();
}

class _ChooseLocationScreenState extends State<ChooseLocationScreen> {
  final _searchTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _searchTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: const CloseButton(),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, kMinInteractiveDimension),
          child: TextField(
            controller: _searchTextController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: localizations.typeSomething,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: _searchTextController,
        builder: (context, child) {
          return _ChooseLocationScreenContent(term: _searchTextController.text);
        },
      ),
    );
  }
}
