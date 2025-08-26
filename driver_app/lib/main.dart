import 'package:driver_app/passwordrecoverypage.dart';
import 'package:flutter/material.dart';
import 'onboardingscreen.dart';
import 'login_screen.dart';
// Main application entry point
void main() {
  runApp(const MyApp());
}

// The root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hides the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Onboarding & Login UI',
      theme: ThemeData(
        // Sets a consistent primary color for the app
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Custom font for the entire app
        fontFamily: 'Roboto',
      ),
      // The initial route is the OnboardingScreen
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/passwordRecovery': (context) => const PasswordRecoveryPage(),
      },
    );
  }
}

