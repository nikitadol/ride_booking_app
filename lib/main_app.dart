import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_booking_app/common/provider/locale_provider.dart';
import 'package:ride_booking_app/constants/colors.dart';
import 'package:ride_booking_app/localization/app_localizations.dart';
import 'package:ride_booking_app/screen/home_screen/home_screen.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      locale: ref.watch(appLocaleProvider),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppColors.lightTheme,
      darkTheme: AppColors.darkTheme,
    );
  }
}
