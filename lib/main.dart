import 'package:flutter/material.dart';

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
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedLanguage = 'EN'; // Options: 'EN', 'SI', 'TA'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.health_and_safety, color: Color(0xFF0066CC), size: 28),
            const SizedBox(width: 8),
            Text(
              'MedScan AI',
              style: TextStyle(
                color: Colors.grey.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          // Language Switcher Toggle
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'EN', label: Text('EN', style: TextStyle(fontSize: 12))),
                ButtonSegment(value: 'SI', label: Text('සිං', style: TextStyle(fontSize: 12))),
                ButtonSegment(value: 'TA', label: Text('த', style: TextStyle(fontSize: 12))),
              ],
              selected: {selectedLanguage},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  selectedLanguage = newSelection.first;
                });
              },
              style: const ButtonStyle(
                visualDensity: VisualDensity.compact,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Greeting Header
            Text(
              selectedLanguage == 'SI'
                  ? 'ආයුබෝවන්, අමල්!'
                  : selectedLanguage == 'TA'
                      ? 'வணக்கம், அமல்!'
                      : 'Hello, Amal!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              selectedLanguage == 'SI'
                  ? 'ඔබේ ඖෂධ කාලසටහන සක්‍රියයි'
                  : selectedLanguage == 'TA'
                      ? 'உங்கள் மருந்து அட்டவணை செயலில் உள்ளது'
                      : 'Your medication routine is on track',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            const SizedBox(height: 20),

            // Dynamic Upcoming Dose Alert Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F0FA),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFB3D4F5)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0066CC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.alarm, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'NEXT DOSE IN 2 HOURS',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0066CC),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Amoxicillin - 500mg',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Take 1 capsule after lunch with water.',
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Main Core Action Buttons (2-Column Grid)
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    context,
                    title: 'Scan Medication',
                    subtitle: 'Pills or Prescriptions',
                    icon: Icons.camera_alt,
                    color: const Color(0xFF0066CC),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Camera scanner opening...')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionCard(
                    context,
                    title: 'My Schedule',
                    subtitle: 'Daily Alarms & Times',
                    icon: Icons.calendar_today,
                    color: const Color(0xFF00A86B),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Schedule feature coming next!')),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Recent Scans List Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Scans',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // History Items
            _buildHistoryTile(
              name: 'Paracetamol 500mg',
              type: 'Pill Scan • AI Verified (96%)',
              time: 'Today, 8:30 AM',
              statusColor: Colors.green,
            ),
            _buildHistoryTile(
              name: 'Metformin 850mg',
              type: 'Prescription OCR Scan',
              time: 'Yesterday, 2:15 PM',
              statusColor: Colors.blue,
            ),
            _buildHistoryTile(
              name: 'Unidentified Medicine',
              type: 'Safety Block Triggered (<85%)',
              time: '10 July 2026',
              statusColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      shadowColor: Colors.black.withAlpha(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryTile({
    required String name,
    required String type,
    required String time,
    required Color statusColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withAlpha(25),
          child: Icon(Icons.medication, color: statusColor, size: 20),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text('$type\n$time', style: const TextStyle(fontSize: 11)),
        isThreeLine: true,
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }
}