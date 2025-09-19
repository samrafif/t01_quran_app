import 'package:flutter/material.dart';
import 'package:t01_quran_app/screens/home_screen.dart';
import 'package:t01_quran_app/screens/view_surah.dart';

class Routes {
  static final String initialRoute = HomeScreen.routeName;

  static final Map<String, Widget Function(BuildContext)> routes = {
    // HomeScreen.routeName: (context) => const HomeScreen(),
    ViewSurah.routeName: (context) => ViewSurah(),
  };
}