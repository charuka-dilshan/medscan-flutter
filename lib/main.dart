import 'package:flutter/material.dart';
import 'package:medscan_flutter/screen/landing_screen.dart';
import 'package:medscan_flutter/screen/login_screen.dart';

void main() {
  runApp(const MedScanApp());
}

class MedScanApp extends StatelessWidget {
  const MedScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedScan AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0066CC), // Medical Blue
          primary: const Color(0xFF0066CC),
          secondary: const Color(0xFF00A86B), // Safety Green
        ),
        useMaterial3: true,
      ),
      home: LandingScreen(),
    );
  }
}
