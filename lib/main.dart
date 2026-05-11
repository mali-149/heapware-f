import 'package:flutter/material.dart';
import './splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Heapware',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.tealAccent,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // Updated from bodyText2
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.tealAccent, width: 2.0),
              borderRadius: BorderRadius.circular(10)

          ),

        ),
      ),

      home: SplashScreen(), // Start with Splash Screen
    );
  }
}
