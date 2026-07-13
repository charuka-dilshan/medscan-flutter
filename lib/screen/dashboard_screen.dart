import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedLanguage = 'EN';
  final ImagePicker _picker = ImagePicker();

  final Map<String, Map<String, String>> localizedData = {
    'EN': {
      'hello': 'Hello, Amal!',
      'scan': 'Scan Medication',
      'pill': 'Pills or Prescriptions',
      'history': 'Recent Scans',
      'sched': 'Today\'s Schedule',
      'success': 'Scan Successful!',
    },
    'SI': {
      'hello': 'ආයුබෝවන්, අමල්!',
      'scan': 'ඖෂධ පරිලෝකනය',
      'pill': 'පෙති හෝ බෙහෙත් වට්ටෝරු',
      'history': 'මෑත ස්කෑන්',
      'sched': 'අද කාලසටහන',
      'success': 'ස්කෑන් සාර්ථකයි!',
    },
    'TA': {
      'hello': 'வணக்கம், அமல்!',
      'scan': 'மருந்து ஸ்கேன்',
      'pill': 'மாத்திரைகள் அல்லது மருந்துகள்',
      'history': 'சமீபத்திய ஸ்கேன்',
      'sched': 'இன்றைய அட்டவணை',
      'success': 'ஸ்கேன் வெற்றி!',
    },
  };

  // --- CAMERA & MODAL LOGIC ---
  Future<void> _captureImage(BuildContext context, String type) async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      if (!mounted) return;
      Navigator.pop(context);
      _showResultModal(context, type);
    }
  }

  void _showResultModal(BuildContext context, String type) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        height: 350,
        child: Column(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 64),
            const SizedBox(height: 16),
            Text(
              localizedData[selectedLanguage]!['success']!,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                "Medication: Paracetamol\nDosage: 500mg\nInstruction: After Lunch",
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Save to History"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showScannerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        height: 250,
        child: Column(
          children: [
            const Text(
              "What would you like to scan?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.description, color: Colors.blue),
              title: const Text("Scan Prescription"),
              onTap: () => _captureImage(context, "Prescription"),
            ),
            ListTile(
              leading: const Icon(Icons.medication, color: Colors.green),
              title: const Text("Scan Pill"),
              onTap: () => _captureImage(context, "Pill"),
            ),
          ],
        ),
      ),
    );
  }

  void _showHistoryModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, controller) => ListView(
          controller: controller,
          padding: const EdgeInsets.all(24),
          children: [
            const Text(
              "Scan History",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildHistoryTile(
              'Paracetamol 500mg',
              'AI Verified (96%)',
              'Today, 8:30 AM',
              Colors.green,
            ),
            _buildHistoryTile(
              'Metformin 850mg',
              'Prescription OCR',
              'Yesterday, 2:15 PM',
              Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  // --- UI COMPONENTS ---
  @override
  Widget build(BuildContext context) {
    final t = localizedData[selectedLanguage]!;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'MedScan AI',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundColor: Color(0xFF0066CC),
              child: Icon(Icons.person, color: Colors.white),
            ),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: 'EN',
                  label: Text('EN', style: TextStyle(fontSize: 10)),
                ),
                ButtonSegment(
                  value: 'SI',
                  label: Text('සිං', style: TextStyle(fontSize: 10)),
                ),
                ButtonSegment(
                  value: 'TA',
                  label: Text('த', style: TextStyle(fontSize: 10)),
                ),
              ],
              selected: {selectedLanguage},
              onSelectionChanged: (s) =>
                  setState(() => selectedLanguage = s.first),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            t['hello']!,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildHighlightCard(
            t['scan']!,
            t['pill']!,
            Icons.qr_code_scanner,
            () => _showScannerOptions(context),
          ),
          const SizedBox(height: 24),
          _buildScheduleList(t['sched']!),
          const SizedBox(height: 24),
          _buildHistoryList(t['history']!),
        ],
      ),
    );
  }

  Widget _buildScheduleList(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: TableCalendar(
            firstDay: DateTime.utc(2026, 1, 1),
            lastDay: DateTime.utc(2026, 12, 31),
            focusedDay: DateTime.now(),
            calendarFormat: CalendarFormat.week,
            availableCalendarFormats: const {CalendarFormat.week: 'Week'},
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryList(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => _showHistoryModal(context),
              child: const Text("View All"),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _buildHistoryTile(
          'Paracetamol 500mg',
          'AI Verified',
          'Today, 8:30 AM',
          Colors.green,
        ),
        _buildHistoryTile(
          'Metformin 850mg',
          'Prescription OCR',
          'Yesterday, 2:15 PM',
          Colors.blue,
        ),
      ],
    );
  }

  Widget _buildHistoryTile(String name, String type, String time, Color color) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withAlpha(20),
          child: Icon(Icons.medication, color: color, size: 20),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text('$type\n$time', style: const TextStyle(fontSize: 11)),
      ),
    );
  }

  Widget _buildHighlightCard(
    String title,
    String sub,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0066CC), Color(0xFF004080)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        leading: Icon(icon, color: Colors.white, size: 40),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(sub, style: const TextStyle(color: Colors.white70)),
      ),
    );
  }
}
