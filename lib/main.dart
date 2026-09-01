import 'package:api_tester/screens/api_tester_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ApiTesterApp());

class ApiTesterApp extends StatelessWidget {
  const ApiTesterApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'REST API Tester',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB)),
          scaffoldBackgroundColor: const Color(0xFFF7F8FC),
        ),
        home: const ApiTesterScreen(),
      );
}
