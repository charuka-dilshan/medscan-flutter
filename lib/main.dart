import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';

void main() {
  // Localization සහ Date Formatting වැඩ කරන්න මේක අනිවාර්යයි
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedScan AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}