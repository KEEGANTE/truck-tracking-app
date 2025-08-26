import 'package:flutter/material.dart';

import 'otpverificationpage.dart';

// Stateful widget for the Password Recovery screen
class PasswordRecoveryPage extends StatefulWidget {
  const PasswordRecoveryPage({super.key});

  @override
  _PasswordRecoveryPageState createState() => _PasswordRecoveryPageState();
}

// State class for the PasswordRecoveryPage
class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  // Controller for the email text field
  final TextEditingController _emailController = TextEditingController();
  // State variable to track if the email field has text
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    // Add a listener to the email controller
    _emailController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _emailController.removeListener(_updateButtonState);
    _emailController.dispose();
    super.dispose();
  }

  // Method to update the button's state based on text field content
  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _emailController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar with a back button and title
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Password Recovery'),
        centerTitle: false, // Align title to the left
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Illustration at the top
            Center(
              child: Image.network(
                'https://placehold.co/200x200/cccccc/ffffff?text=Password+Recovery', // Placeholder image URL
                height: 200,
                width: 200,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, size: 100, color: Colors.grey);
                },
              ),
            ),
            const SizedBox(height: 48.0), // Space below the illustration

            // Email input field
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _emailController, // Assign the controller
              onChanged: (text) {
                // The listener already handles this, but it's good practice
                // to have it here as well for clarity.
                _updateButtonState();
              },
              decoration: InputDecoration(
                hintText: 'yourmail@email.com',
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none, // No visible border
                ),
                filled: true,
                fillColor: Colors.grey[200], // Light grey background
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 20.0,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 48.0), // Space before the button

            // Send Code Button
            ElevatedButton(
              onPressed: _isButtonEnabled
                  ? () {
                // Navigate to the OTPVerificationPage
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OTPVerificationPage(
                      email: _emailController.text,
                    ),
                  ),
                );
              }
                  : null, // Set onPressed to null to disable the button
              style: ElevatedButton.styleFrom(
                // Use a conditional color for the background
                backgroundColor: _isButtonEnabled ? Colors.amber : Colors.grey[300],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 3,
              ),
              child: const Text(
                'Send Code',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}