import 'package:api_tester/screens/fixmate_home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const FixMateApp());

class FixMateApp extends StatelessWidget {
  const FixMateApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'FixMate — Laptop Service & Repair',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFD9671E),
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: Colors.white,
      textTheme: ThemeData.light().textTheme.apply(
        bodyColor: const Color(0xFF211F1D),
        displayColor: const Color(0xFF211F1D),
      ),
    ),
    home: const FixMateHomeScreen(),
  );
}
