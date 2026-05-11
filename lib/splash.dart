import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './onbording.dart'; // Ensure onboarding screen is imported

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => OnboardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/background.jpg', // Replace with actual image
            fit: BoxFit.cover,
          ),
          // Dark Overlay
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          // Centered Content
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Heapware Logo
                Image.asset(
                  'assets/images/logo.png',
                  width: 80,
                ),
                // Centered Loading Indicator on top of the logo
                SpinKitFadingCircle(
                  color: Colors.black,
                  size: 60, // Slightly smaller to fit over the logo
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}
