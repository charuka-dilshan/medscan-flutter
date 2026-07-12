import 'package:flutter/material.dart';
import 'login_screen.dart'; // Your LoginScreen
import 'medical_info_screen.dart'; // Your Registration/MedicalInfoScreen

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.medication_rounded, size: 100, color: Colors.teal),
            const SizedBox(height: 30),
            const Text(
              "MedScan AI",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Welcome, how can we help you today?",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 60),

            // Sign In Button (Primary)
            _buildAction(context, "Sign In", Colors.teal, true, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            }),
            const SizedBox(height: 20),

            // Register Button (Secondary)
            _buildAction(
              context,
              "Create New Account",
              Colors.white,
              false,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MedicalInfoScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(
    BuildContext context,
    String text,
    Color color,
    bool isPrimary,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(
          color: isPrimary ? color : color,
          borderRadius: BorderRadius.circular(20),
          border: isPrimary ? null : Border.all(color: Colors.teal, width: 2),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isPrimary ? Colors.white : Colors.teal,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
