import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'CoachCalendar.dart'; // تأكد من اسم الملف الصحيح

class DatesTr extends StatefulWidget {
  const DatesTr({super.key, required this.title});
  final String title;

  @override
  State<DatesTr> createState() => _DatesTrPageState();
}

class _DatesTrPageState extends State<DatesTr> {
  List<DateTime> availableDatesWithTimes = [];

  Future<void> _pickDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final combined = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          availableDatesWithTimes.add(combined);
        });
      }
    }
  }

  void _removeDate(DateTime date) {
    setState(() {
      availableDatesWithTimes.remove(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEE, MMM d yyyy - hh:mm a');

    return Scaffold(
      body: Stack(
        children: [
          // خلفية ناعمة متدرجة
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE0C3FC), Color(0xFF8EC5FC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🗓️ My Available Times',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _pickDateTime,
                    icon: const Icon(Icons.add),
                    label: const Text("Add Date & Time"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.3),
                      foregroundColor: Colors.deepPurple,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: availableDatesWithTimes.isEmpty
                        ? const Center(
                      child: Text("No available times selected."),
                    )
                        : ListView.builder(
                      itemCount: availableDatesWithTimes.length,
                      itemBuilder: (context, index) {
                        final date = availableDatesWithTimes[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.4),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x22000000),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: ListTile(
                                leading: const Icon(Icons.event_available, color: Colors.green),
                                title: Text(
                                  dateFormat.format(date),
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _removeDate(date),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CoachCalendarScreen(),
              ),
            );
          }
        },
        backgroundColor: Colors.white.withOpacity(0.95),
        elevation: 10,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
            label: 'My Dates',
          ),
        ],
      ),
    );
  }
}
