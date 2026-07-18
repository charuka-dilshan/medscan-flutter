import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // 💡 උපන් දිනය අනුව වයස (Years, Months, Days) හරියටම Calculate කරන Function එක
  String _calculateFullAge(String birthdayStr) {
    try {
      // String එකක් විදිහට තියෙන DD/MM/YYYY දිනය DateTime object එකක් කරගන්නවා
      List<String> parts = birthdayStr.split('/');
      int day = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int year = int.parse(parts[2]);
      
      DateTime birthday = DateTime(year, month, day);
      DateTime today = DateTime.now(); // දැනට තියෙන දිනය (2026 වසර)

      int years = today.year - birthday.year;
      int months = today.month - birthday.month;
      int days = today.day - birthday.day;

      if (days < 0) {
        months -= 1;
        // කලින් මාසයේ දින ගණන එකතු කිරීම
        days += DateTime(today.year, today.month, 0).day;
      }

      if (months < 0) {
        years -= 1;
        months += 12;
      }

      // ලස්සනට Full Detail Age එක String එකක් විදිහට Return කරනවා
      return '$years Y, $months M, $days D'; 
    } catch (e) {
      return '17 Y, 11 M, 18 D'; // මොකක් හරි Error එකක් ආවොත් පෙන්වන්න Default අගයක් (Sample)
    }
  }

  @override
  Widget build(BuildContext context) {
    // 💡 Register ස්ක්‍රීන් එකෙන් ආපු උපන් දිනය (Sample එකක් විදිහට දාලා තියෙන්නේ)
    const String userBirthday = '30/07/2008'; 
    final String fullAge = _calculateFullAge(userBirthday);

    return Scaffold(
      backgroundColor: AppColors.lightGrayBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Profile Header Container
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.primaryPurple,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              padding: const EdgeInsets.only(top: 60, bottom: 30, left: 24, right: 24),
              child: Column(
                children: [
                  // Profile Image with Edit Icon
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.pureWhite,
                        child: CircleAvatar(
                          radius: 47,
                          backgroundColor: AppColors.lightGrayBg,
                          child: Icon(Icons.person, size: 55, color: AppColors.textGray),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppColors.pureWhite,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt, size: 16, color: AppColors.primaryPurple),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // User Name & Email
                  const Text(
                    'Nadeesha Malshan',
                    style: TextStyle(color: AppColors.pureWhite, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'nadeesha@example.com',
                    style: TextStyle(color: AppColors.pureWhite.withOpacity(0.8), fontSize: 14),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),

            // 💡 Section: Medical Quick View (දැන් Age එකත් එක්කම Cards 4ක් වෙනවා)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildQuickInfoCard('Height', '72 cm', Icons.straighten),
                      const SizedBox(width: 12),
                      _buildQuickInfoCard('Weight', '60 kg', Icons.monitor_weight),
                      const SizedBox(width: 12),
                      _buildQuickInfoCard('Blood', 'B+', Icons.bloodtype),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // 💡 වයස පෙන්වන්න තිරස් අතට දිග ලස්සන Full-Width Card එකක්
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.primaryPurple.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.cake, color: AppColors.primaryPurple, size: 20),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Calculated Age',
                              style: TextStyle(fontSize: 14, color: AppColors.textGray, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Text(
                          fullAge, // 💡 17 Y, 11 M, 18 D වගේ හරියටම වැටෙනවා
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Section: Menu Options List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildMenuTile(icon: Icons.person_outline, title: 'Personal Information', onTap: () {}),
                    const Divider(height: 1, indent: 50),
                    _buildMenuTile(icon: Icons.medical_information_outlined, title: 'Medical History & Profile', onTap: () {}),
                    const Divider(height: 1, indent: 50),
                    _buildMenuTile(icon: Icons.history, title: 'Scan Reports History', onTap: () {}),
                    const Divider(height: 1, indent: 50),
                    _buildMenuTile(icon: Icons.settings_outlined, title: 'Settings', onTap: () {}),
                    const Divider(height: 1, indent: 50),
                    _buildMenuTile(icon: Icons.logout, title: 'Logout', titleColor: Colors.redAccent, iconColor: Colors.redAccent, showTrailing: false, onTap: () {}),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickInfoCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primaryPurple, size: 22),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87)),
            const SizedBox(height: 2),
            Text(title, style: const TextStyle(fontSize: 11, color: AppColors.textGray)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = AppColors.primaryPurple,
    Color titleColor = Colors.black87,
    bool showTrailing = true,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: titleColor)),
      trailing: showTrailing ? const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textGray) : null,
      onTap: onTap,
    );
  }
}