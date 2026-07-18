import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'profile/profile_screen.dart'; // 💡 Profile Screen එක import කරගන්න

class DashboardScreen extends StatefulWidget {
  final String firstName;
  final String weight;
  final String bloodGroup;

  const DashboardScreen({
    super.key,
    required this.firstName,
    required this.weight,
    required this.bloodGroup,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // දැනට සිලෙක්ට් වෙලා තියෙන Screen index එක (0 = Home Dashboard)
  int _selectedIndex = 0;

  // Navigation එකෙන් මාරු වෙන්න ඕන Screens ලැයිස්තුව
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      _buildDashboardHome(), // index 0: Dashboard ප්‍රධාන පිටුව
      const Center(
        child: Text('History Screen', style: TextStyle(fontSize: 20)),
      ), // index 1
      const Center(
        child: Text('Reminder Screen', style: TextStyle(fontSize: 20)),
      ), // index 2
      const ProfileScreen(), // index 3: අපේ Profile Screen එක 🚀
    ];
  }

  // 💡 ප්‍රධාන Dashboard UI එක (Index 0 සඳහා)
  Widget _buildDashboardHome() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 1. Top Purple Header Section
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.primaryPurple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 30,
              left: 24,
              right: 24,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.pureWhite,
                      child: Icon(
                        Icons.person,
                        color: AppColors.textGray,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, ${widget.firstName}!',
                          style: const TextStyle(
                            color: AppColors.pureWhite,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '"Your health, our priority"',
                          style: TextStyle(
                            color: const Color(0xCCFFFFFF),
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Notification Bell Icon
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_none,
                        color: AppColors.pureWhite,
                        size: 28,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Medical Info Chips Row (දත්ත dynamic ලෙස වෙනස් වේ)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoChip(
                      Icons.bloodtype,
                      'Blood: ${widget.bloodGroup}',
                    ),
                    _buildInfoChip(
                      Icons.monitor_weight,
                      'Weight: ${widget.weight}kg',
                    ),
                    _buildInfoChip(Icons.favorite, 'Status: Fit'),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 2. Middle Content Section (Confidence & History)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Card: Confidence Level
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
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
                        const Text(
                          'Confidence Level',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Circular Progress Chart UI
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 90,
                              height: 90,
                              child: CircularProgressIndicator(
                                value: 0.92,
                                strokeWidth: 10,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.teal,
                                ),
                                backgroundColor: Colors.grey[200],
                              ),
                            ),
                            const Column(
                              children: [
                                Text(
                                  '92%',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.teal,
                                  ),
                                ),
                                Text(
                                  'Match',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.textGray,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // AI Confidence Green Badge (We fixed py and withOpacity here!)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.teal.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'AI Confidence: High',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Right Card: Recent Status History
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Recent Status History',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildHistoryItem(
                          'Amoxicillin 500...',
                          '96%',
                          Colors.green,
                        ),
                        _buildHistoryItem(
                          'Paracetamol 50...',
                          '98%',
                          Colors.green,
                        ),
                        _buildHistoryItem('Vitamin C', '94%', Colors.green),
                        const SizedBox(height: 12),
                        Center(
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'See All Scans',
                              style: TextStyle(
                                color: AppColors.primaryPurple,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // 💡 Main Scaffold Builder
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrayBg,
      // දැනට සිලෙක්ට් වෙලා තියෙන පිටුව body එකට පෙන්වනවා
      body: SafeArea(child: _screens[_selectedIndex]),

      // 💡 3. Custom Bottom Navigation Bar UI (With floating scan button style)
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.dashboard, 'Dashboard', 0),
            _buildNavItem(Icons.history, 'History', 1),

            // මැද තියෙන රවුම් Scan බටන් එක
            GestureDetector(
              onTap: () {
                // ස්කෑන් කරන්න කැමරාව ඕපන් වන logic එක මෙතනට
              },
              child: Container(
                transform: Matrix4.translationValues(
                  0,
                  -10,
                  0,
                ), // බටන් එක පොඩ්ඩක් උඩට ගන්න
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  color: AppColors.primaryPurple,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryPurple,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.document_scanner,
                  color: AppColors.pureWhite,
                  size: 28,
                ),
              ),
            ),

            _buildNavItem(Icons.notifications_none, 'Reminder', 2),
            _buildNavItem(
              Icons.person_outline,
              'Profile',
              3,
            ), // 👈 Profile Button
          ],
        ),
      ),
    );
  }

  // Helper: Top Info Chips
  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.pureWhite.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.pureWhite, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.pureWhite,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Helper: History List Item
  Widget _buildHistoryItem(String title, String percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.medical_services_outlined,
              color: AppColors.primaryPurple,
              size: 16,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              percentage,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper: Bottom Navigation Item Layout
  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex =
              index; // ක්ලික් කරපු ගමන් index එක අප්ඩේට් වී Screen එක මාරු වේ.
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primaryPurple : AppColors.textGray,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? AppColors.primaryPurple : AppColors.textGray,
            ),
          ),
        ],
      ),
    );
  }
}
