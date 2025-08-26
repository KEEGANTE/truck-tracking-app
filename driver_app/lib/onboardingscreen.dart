import 'package:flutter/material.dart';

// Stateless widget for the onboarding screen
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sets the background color of the scaffold
      backgroundColor: const Color(0xFFE3F2FD), // Light blue background
      body: Stack(
        children: [
          // Main content column
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Placeholder for the top illustration
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Center(
                    child: Container(
                      height: 250,
                      width: 250,
                      color: Colors.transparent, // Placeholder for the rocket image
                      child: const Center(
                        child: Text(
                          "Illustration Placeholder",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Spacing before the main content card
              const SizedBox(height: 20),
            ],
          ),
          // Positioned card at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
              decoration: const BoxDecoration(
                color: Color(0xFFFDCB61), // Orange-yellow color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title text
                  const Text(
                    'The whole company in your pocket',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Subtitle text
                  const Text(
                    'Get all your HR related tasks in one place. easy, quick, reliable',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 48),
                  // "Get Started" button
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to the next screen or home page
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFDCB61), // Text color to match the card
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}