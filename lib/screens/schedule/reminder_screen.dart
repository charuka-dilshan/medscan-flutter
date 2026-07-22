import 'package:flutter/material.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  DateTime _selectedDate = DateTime.now();

  // 🧪 ටෙස්ට් කරලා බලන්න Sample Reminders Data ටිකක්
  final List<Map<String, dynamic>> _reminders = [
    {
      'title': 'Amoxicillin 500mg',
      'time': '08:00 AM',
      'type': 'Pill',
      'isActive': true,
      'instructions': 'After Meals',
    },
    {
      'title': 'Blood Pressure Check',
      'time': '02:00 PM',
      'type': 'Measurement',
      'isActive': true,
      'instructions': 'Rest for 5 mins before',
    },
    {
      'title': 'Vitamin D Supplement',
      'time': '08:00 PM',
      'type': 'Pill',
      'isActive': false,
      'instructions': 'With Water',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),
      appBar: AppBar(
        title: const Text(
          'Reminders & Schedule',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Open Add Reminder Dialog / Bottom Sheet
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. 📅 Horizontal Calendar Picker (දින තෝරන කොටස)
            _buildCalendarSection(),
            const SizedBox(height: 20),

            // 2. ⏳ Next Reminder Countdown Timer Card
            _buildNextReminderTimerCard(),
            const SizedBox(height: 24),

            // 3. 🔔 Reminders List Header
            const Text(
              "Today's Schedule",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // 4. 📇 Reminders Cards List
            _reminders.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _reminders.length,
                    itemBuilder: (context, index) {
                      return _buildReminderCard(index);
                    },
                  ),
          ],
        ),
      ),
    );
  }

  // 📅 Horizontal Calendar Strip Widget
  Widget _buildCalendarSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(5, (index) {
          DateTime date = DateTime.now().add(Duration(days: index - 2));
          bool isSelected = date.day == _selectedDate.day;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][date.weekday % 7],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // ⏳ Next Dose Countdown Banner
  Widget _buildNextReminderTimerCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.timer, color: Colors.white, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Next Dose in 03h 25m',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Amoxicillin 500mg - 02:00 PM',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 📇 Single Reminder Card
  Widget _buildReminderCard(int index) {
    final item = _reminders[index];
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            item['type'] == 'Pill' ? Icons.medication : Icons.health_and_safety,
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Text(
          item['title'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: item['isActive'] ? TextDecoration.none : TextDecoration.lineThrough,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('${item['time']} • ${item['instructions']}'),
          ],
        ),
        trailing: Switch(
          value: item['isActive'],
          onChanged: (bool value) {
            setState(() {
              _reminders[index]['isActive'] = value;
            });
          },
        ),
      ),
    );
  }

  // 📭 Empty State
  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Text('No reminders set for this day.'),
      ),
    );
  }
}