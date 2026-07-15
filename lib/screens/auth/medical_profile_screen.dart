import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../dashboard/dashboard_screen.dart'; // 💡 ඔයාගේ dashboard එකට යන්න මේ import එක ඕනේ

class MedicalProfileScreen extends StatefulWidget {
  const MedicalProfileScreen({super.key});

  @override
  State<MedicalProfileScreen> createState() => _MedicalProfileScreenState();
}

class _MedicalProfileScreenState extends State<MedicalProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  
  String? _selectedBloodGroup;

  // ලේසියෙන් select කරන්න ලෙඩ රෝග ලැයිස්තුව
  final List<String> _medicalConditions = [
    'Diabetes (දියවැඩියාව)',
    'Hypertension (අධික රුධිර පීඩනය)',
    'Heart Disease (හෘද රෝග)',
    'Asthma (ඇදුම)',
    'None (කිසිවක් නැත)'
  ];
  final List<String> _selectedConditions = [];

  // අසාත්මිකතා ලැයිස්තුව (Allergies)
  final List<String> _allergies = [
    'Penicillin',
    'Aspirin',
    'Sulfa Drugs',
    'Peanuts (රටකජු)',
    'None (කිසිවක් නැත)'
  ];
  final List<String> _selectedAllergies = [];

  final List<String> _bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrayBg,
      body: Stack(
        children: [
          // Top Purple Background Accent
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
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
                    const SizedBox(height: 10),
                    // Skip Button at top right
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          // Skip කරලා කෙලින්ම Dashboard එකට යන්න
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const Scaffold(body: Center(child: Text("Dashboard Coming Soon")))),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'Skip',
                          style: TextStyle(color: AppColors.pureWhite, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Complete Your Profile',
                      style: TextStyle(
                        color: AppColors.pureWhite,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'This helps our AI provide safe recommendations',
                      style: TextStyle(color: AppColors.pureWhite, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),

                    // Main Form Card
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
                            const Text(
                              'Medical Information',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Height & Weight Fields (Row)
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _heightController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Height (cm)',
                                      labelStyle: TextStyle(color: AppColors.textGray),
                                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.textGray)),
                                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primaryPurple)),
                                    ),
                                    validator: (value) => value!.isEmpty ? 'Enter height' : null,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: TextFormField(
                                    controller: _weightController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Weight (kg)',
                                      labelStyle: TextStyle(color: AppColors.textGray),
                                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.textGray)),
                                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primaryPurple)),
                                    ),
                                    validator: (value) => value!.isEmpty ? 'Enter weight' : null,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Blood Group Dropdown
                            DropdownButtonFormField<String>(
                              value: _selectedBloodGroup,
                              hint: const Text('Select Blood Group', style: TextStyle(color: AppColors.textGray)),
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.textGray)),
                              ),
                              items: _bloodGroups.map((group) {
                                return DropdownMenuItem(
                                  value: group,
                                  child: Text(group),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedBloodGroup = value;
                                });
                              },
                              validator: (value) => value == null ? 'Select blood group' : null,
                            ),
                            const SizedBox(height: 24),

                            // Medical Conditions Chips
                            const Text(
                              'Do you have any of these conditions?',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8.0,
                              runSpacing: 4.0,
                              children: _medicalConditions.map((condition) {
                                final isSelected = _selectedConditions.contains(condition);
                                return FilterChip(
                                  label: Text(condition, style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : Colors.black87)),
                                  selected: isSelected,
                                  selectedColor: AppColors.primaryPurple,
                                  checkmarkColor: Colors.white,
                                  backgroundColor: Colors.grey[200],
                                  onSelected: (selected) {
                                    setState(() {
                                      if (selected) {
                                        if (condition == 'None (කිසිවක් නැත)') {
                                          _selectedConditions.clear();
                                        } else {
                                          _selectedConditions.remove('None (කිසිවක් නැත)');
                                        }
                                        _selectedConditions.add(condition);
                                      } else {
                                        _selectedConditions.remove(condition);
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 24),

                            // Allergies Chips
                            const Text(
                              'Do you have any drug/food allergies?',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8.0,
                              runSpacing: 4.0,
                              children: _allergies.map((allergy) {
                                final isSelected = _selectedAllergies.contains(allergy);
                                return FilterChip(
                                  label: Text(allergy, style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : Colors.black87)),
                                  selected: isSelected,
                                  selectedColor: AppColors.primaryPurple,
                                  checkmarkColor: Colors.white,
                                  backgroundColor: Colors.grey[200],
                                  onSelected: (selected) {
                                    setState(() {
                                      if (selected) {
                                        if (allergy == 'None (කිසිවක් නැත)') {
                                          _selectedAllergies.clear();
                                        } else {
                                          _selectedAllergies.remove('None (කිසිවක් නැත)');
                                        }
                                        _selectedAllergies.add(allergy);
                                      } else {
                                        _selectedAllergies.remove(allergy);
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 32),

                            // Submit Button
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
                                    // 💡 මෙතනදී දත්ත ටික database එකට දාන්න පුළුවන්
                                    // වැඩේ ඉවර වෙලා Dashboard එකට යන්න:
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Scaffold(body: Center(child: Text("Dashboard Coming Soon")))),
                                      (route) => false,
                                    );
                                  }
                                },
                                child: const Text(
                                  'SAVE & CONTINUE',
                                  style: TextStyle(color: AppColors.pureWhite, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
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