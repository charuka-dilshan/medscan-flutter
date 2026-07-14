import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 💡 pubspec.yaml එකට intl දැම්මාට පස්සේ මේක වැඩ
import '../../theme/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _birthdayController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  // Native Date Picker Functionality
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)), // default to 18 years ago
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryPurple,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _birthdayController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrayBg,
      body: Stack(
        children: [
          // Top Purple Background Accent
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            decoration: const BoxDecoration(
              color: AppColors.primaryPurple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Title
                    const Text(
                      'MedScan AI',
                      style: TextStyle(
                        color: AppColors.pureWhite,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Fill The Below information to Register',
                      style: TextStyle(color: AppColors.pureWhite, fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    
                    // Main White Form Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.pureWhite,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          )
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                'Create New Account',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            
                            // First Name Field
                            TextFormField(
                              controller: _firstNameController,
                              textCapitalization: TextCapitalization.words,
                              decoration: const InputDecoration(
                                labelText: 'User First Name',
                                labelStyle: TextStyle(color: AppColors.textGray),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.textGray)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primaryPurple)),
                              ),
                              validator: (value) => value!.isEmpty ? 'Enter your first name' : null,
                            ),
                            const SizedBox(height: 12),
                            
                            // Last Name Field
                            TextFormField(
                              controller: _lastNameController,
                              textCapitalization: TextCapitalization.words,
                              decoration: const InputDecoration(
                                labelText: 'User Last Name',
                                labelStyle: TextStyle(color: AppColors.textGray),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.textGray)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primaryPurple)),
                              ),
                              validator: (value) => value!.isEmpty ? 'Enter your last name' : null,
                            ),
                            const SizedBox(height: 12),
                            
                            // Phone Number Field
                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                labelText: 'User Phone Number',
                                labelStyle: TextStyle(color: AppColors.textGray),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.textGray)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primaryPurple)),
                              ),
                              validator: (value) => value!.isEmpty ? 'Enter your phone number' : null,
                            ),
                            const SizedBox(height: 12),
                            
                            // Password Field
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(color: AppColors.textGray),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.textGray)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primaryPurple)),
                              ),
                              validator: (value) => value!.length < 6 ? 'Password must be 6+ characters' : null,
                            ),
                            const SizedBox(height: 12),
                            
                            // Birthday Field with DatePicker Triger
                            TextFormField(
                              controller: _birthdayController,
                              readOnly: true,
                              onTap: () => _selectDate(context),
                              decoration: const InputDecoration(
                                labelText: 'Birthday (DD/MM/YYYY)',
                                labelStyle: TextStyle(color: AppColors.textGray),
                                suffixIcon: Icon(Icons.calendar_today, color: AppColors.textGray, size: 20),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.textGray)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primaryPurple)),
                              ),
                              validator: (value) => value!.isEmpty ? 'Select your birthday' : null,
                            ),
                            const SizedBox(height: 24),
                            
                            // Register Button
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryPurple,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Handle Registration Logic
                                  }
                                },
                                child: const Text(
                                  'REGISTER',
                                  style: TextStyle(color: AppColors.pureWhite, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Already have an account text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? ", style: TextStyle(color: Colors.black54)),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Text(
                            'LOG IN',
                            style: TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}