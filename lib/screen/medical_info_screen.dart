import 'package:flutter/material.dart';
import '../widgets/custom_pill_card.dart';

class MedicalInfoScreen extends StatefulWidget {
  const MedicalInfoScreen({super.key});

  @override
  State<MedicalInfoScreen> createState() => _MedicalInfoScreenState();
}

class _MedicalInfoScreenState extends State<MedicalInfoScreen> {
  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  bool hasDiabetes = false;
  bool hasHypertension = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text("Create Account", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF1E293B),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Personal Information
            const Text("Profile Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            _buildTextField("Full Name", _nameController, Icons.person_outline),
            _buildTextField("Mobile Number", _phoneController, Icons.phone_android),
            _buildTextField("Set Password", _passwordController, Icons.lock_outline, isPassword: true),

            const SizedBox(height: 30),
            
            // 2. Measurements
            const Text("Measurements", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            _buildTextField("Weight (kg)", _weightController, Icons.monitor_weight_outlined),
            _buildTextField("Height (cm)", _heightController, Icons.height_outlined),

            const SizedBox(height: 30),
            
            // 3. Chronic Conditions
            const Text("Chronic Conditions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            CustomPillCard(label: "Diabetes", isSelected: hasDiabetes, onTap: () => setState(() => hasDiabetes = !hasDiabetes)),
            CustomPillCard(label: "High Blood Pressure", isSelected: hasHypertension, onTap: () => setState(() => hasHypertension = !hasHypertension)),

            const SizedBox(height: 50),
            
            // Registration Button
            GestureDetector(
              onTap: () {
                // Here you would call your Registration API/Database logic
                print("Registering: ${_nameController.text}, ${_phoneController.text}");
              },
              child: Container(
                width: double.infinity, height: 65,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF26A69A), Color(0xFF00796B)]),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.teal.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8))],
                ),
                child: const Center(child: Text("Complete Registration", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: isPassword ? TextInputType.visiblePassword : TextInputType.text,
        decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon, color: Colors.teal), border: InputBorder.none),
      ),
    );
  }
}