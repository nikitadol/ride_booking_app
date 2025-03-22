import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_booking_app/localization/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_provider.g.dart';

@riverpod
class AppLocale extends _$AppLocale {
  @override
  Locale build() {
    final userLocales = WidgetsBinding.instance.platformDispatcher.locales;

    return basicLocaleListResolution(
      userLocales,
      AppLocalizations.supportedLocales,
    );
  }
}

@riverpod
String appLocaleTag(Ref ref) {
  return ref.watch(appLocaleProvider).toString();
}
