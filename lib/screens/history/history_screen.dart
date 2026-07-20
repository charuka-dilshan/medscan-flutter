import 'package:flutter/material.dart';
// TODO: ඔයාගේ AppColors තියෙන path එක හරියටම දාන්න (e.g., import '../../theme/app_colors.dart';)

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ටෙස්ට් කරලා බලන්න Sample Data ටිකක් (පස්සේ API එකෙන් මේවා ගමු)
    final List<Map<String, String>> historyData = [
      {
        'date': '2026-07-18',
        'title': 'Full Body Checkup',
        'result': 'Normal',
        'status': 'Completed'
      },
      {
        'date': '2026-06-05',
        'title': 'Blood Sugar Test',
        'result': 'High Blood Sugar',
        'status': 'Action Required'
      },
      {
        'date': '2026-04-12',
        'title': 'Report Analysis',
        'result': 'Mild Deficiency',
        'status': 'Completed'
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa), // Light background එකක්
      appBar: AppBar(
        title: const Text(
          'Scan History',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: historyData.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: historyData.length,
              itemBuilder: (context, index) {
                final item = historyData[index];
                return _buildHistoryCard(item);
              },
            ),
    );
  }

  // 📇 History එක පෙන්වන Card Widget එක
  Widget _buildHistoryCard(Map<String, String> item) {
    final bool isActionRequired = item['status'] == 'Action Required';

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // වම් පැත්තේ Icon එක (Status එක අනුව පාට වෙනස් වෙනවා)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isActionRequired 
                    ? Colors.red.withOpacity(0.1) 
                    : Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isActionRequired ? Icons.warning_amber_rounded : Icons.check_circle_outline,
                color: isActionRequired ? Colors.red : Colors.green,
              ),
            ),
            const SizedBox(width: 16),
            
            // මැද විස්තර ටික
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Result: ${item['result']}',
                    style: TextStyle(
                      fontSize: 14,
                      color: isActionRequired ? Colors.red.shade700 : Colors.grey.shade700,
                      fontWeight: isActionRequired ? FontWeight.w500 : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['date'] ?? '',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
            
            // දකුණු පැත්තේ Arrow Icon එකක් (වැඩිදුර විස්තර බලන්න)
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  // 📭 කිසිම history එකක් නැති වෙලාවට පෙන්වන UI එක
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_toggle_off, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No history found',
            style: TextStyle(fontSize: 18, color: Colors.grey.shade600, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Your medical scan history will appear here.',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}