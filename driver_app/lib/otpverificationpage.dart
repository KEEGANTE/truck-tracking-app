import 'package:driver_app/setnewpasswordpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPVerificationPage extends StatefulWidget {
  final String email;

  const OTPVerificationPage({super.key, required this.email});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  // Controllers for the 4 OTP input fields
  final List<TextEditingController> _otpControllers =
  List.generate(4, (index) => TextEditingController());
  // List to hold focus nodes for each input field
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  // State variable to track if all fields are filled
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    // Add listeners to all OTP controllers to check for input
    for (var controller in _otpControllers) {
      controller.addListener(_updateButtonState);
    }
  }

  @override
  void dispose() {
    // Dispose all controllers and focus nodes
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  // Method to check if all OTP fields are filled
  void _updateButtonState() {
    final bool allFieldsFilled = _otpControllers.every((controller) => controller.text.isNotEmpty);
    setState(() {
      _isButtonEnabled = allFieldsFilled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Password Recovery'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Illustration for OTP
            Center(
              child: Image.network(
                'https://placehold.co/200x200/cccccc/ffffff?text=OTP+Code', // Placeholder for OTP image
                height: 200,
                width: 200,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, size: 100, color: Colors.grey);
                },
              ),
            ),
            const SizedBox(height: 48.0),

            // Text to show where the OTP was sent
            Text(
              "We've sent an OTP code to \"${widget.email}\".\nEnter the code below to set a new password",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16.0, color: Colors.black54),
            ),
            const SizedBox(height: 24.0),

            // OTP input fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 60.0,
                  child: TextField(
                    controller: _otpControllers[index],
                    focusNode: _focusNodes[index],
                    autofocus: index == 0, // Auto-focus on the first field
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(1),
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      counterText: "", // Hide character counter
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        if (index < _otpControllers.length - 1) {
                          FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                        } else {
                          // All fields filled, unfocus keyboard
                          _focusNodes[index].unfocus();
                        }
                      }
                      _updateButtonState();
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 24.0),

            // Resend code option
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn't receive yet? ", style: TextStyle(color: Colors.black54)),
                TextButton(
                  onPressed: () {
                    // TODO: Implement resend code functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Request again!')),
                    );
                  },
                  child: const Text(
                    'Request again',
                    style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48.0),

            // Verify button
            ElevatedButton(
              onPressed: _isButtonEnabled
                  ? () {
                // Navigate to the SetNewPasswordPage
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SetNewPasswordPage(),
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
                'Verify',
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