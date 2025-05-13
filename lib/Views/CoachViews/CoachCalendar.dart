import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'DatesTr.dart'; // تأكد من اسم الملف الصحيح

class CoachCalendarScreen extends StatefulWidget {
  const CoachCalendarScreen({super.key});

  @override
  State<CoachCalendarScreen> createState() => _CoachCalendarScreenState();
}

class _CoachCalendarScreenState extends State<CoachCalendarScreen> {
  DateTime selectedDate = DateTime.now();

  final List<DateTime> dates = List.generate(
    30,
        (index) => DateTime.now().add(Duration(days: index)),
  );

  final Map<DateTime, List<Task>> dailyTasks = {
    DateTime.now(): [
      Task(customerName: "Ahmed Abdullah", time: "10:00 AM"),
      Task(customerName: "Sarah Mansour", time: "12:00 PM"),
    ],
    DateTime.now().add(Duration(days: 1)): [
      Task(customerName: "Laila Khalil", time: "9:30 AM"),
    ],
  };

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = dailyTasks[selectedDate] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Stack(
        children: [
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📅 Calendar',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildDatePicker(),
                  const SizedBox(height: 30),
                  Expanded(
                    child: tasks.isEmpty
                        ? const Center(
                      child: Text(
                        "No tasks for this day",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    )
                        : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) => _buildTaskCard(tasks[index]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DatesTr(title: 'Available Dates'),
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

  Widget _buildDatePicker() {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected = date.day == selectedDate.day &&
              date.month == selectedDate.month &&
              date.year == selectedDate.year;

          return GestureDetector(
            onTap: () => setState(() => selectedDate = date),
            child: Container(
              width: 72,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withOpacity(0.2) : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isSelected ? Colors.deepPurple : Colors.transparent),
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
                    : [],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('d').format(date),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.deepPurple : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('MMM').format(date),
                        style: TextStyle(
                          fontSize: 14,
                          color: isSelected ? Colors.deepPurple : Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTaskCard(Task task) {
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("👤 ${task.customerName}",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text("⏰ ${task.time}",
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade800)),
                    ]),
                const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.deepPurple),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Task {
  final String customerName;
  final String time;
  Task({required this.customerName, required this.time});
}
