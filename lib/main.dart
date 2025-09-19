import 'package:flutter/material.dart';
import 'package:t01_quran_app/core/routes.dart';
import 'package:t01_quran_app/core/theme.dart';
import 'package:t01_quran_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuranQu',
      theme: CustomTheme.lightTheme(),
      // darkTheme: CustomTheme.darkTheme(),
      home: const HomeScreen(),
      routes: Routes.routes,
      initialRoute: Routes.initialRoute,
    );
  }
}