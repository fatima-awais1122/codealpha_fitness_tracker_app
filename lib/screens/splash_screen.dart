import 'dart:async';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F0),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.fitness_center,
                color: Color(0xFF4CAF88),
                size: 90,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Fitness Tracker",
              style: TextStyle(
                color: Color(0xFF2D3748),
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Track Your Daily Fitness Goals",
              style: TextStyle(color: Color(0xFF718096), fontSize: 16),
            ),

            const SizedBox(height: 40),

            const CircularProgressIndicator(color: Color(0xFF4CAF88)),
          ],
        ),
      ),
    );
  }
}
