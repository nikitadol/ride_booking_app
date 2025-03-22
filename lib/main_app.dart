import 'package:flutter/material.dart';
import 'package:ride_booking_app/constants/colors.dart';
import 'package:ride_booking_app/localization/app_localizations.dart';
import 'package:ride_booking_app/screen/home_screen/home_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppColors.lightTheme,
      darkTheme: AppColors.darkTheme,
    );
  }
}
