import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const FitnessTrackerApp());
}

class FitnessTrackerApp extends StatelessWidget {
  const FitnessTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Tracker',
      theme: ThemeData(
        useMaterial3: true,

        scaffoldBackgroundColor: const Color(0xFFF8F6F0),

        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4CAF88)),
      ),
      home: const SplashScreen(),
    );
  }
}
