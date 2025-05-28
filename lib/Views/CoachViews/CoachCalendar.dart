import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'DatesTr.dart';

// موديل المواعيد
class CalendarEvent {
  final String coachID;
  final String startHour;
  final String fullName;

  CalendarEvent({
    required this.coachID,
    required this.startHour,
    required this.fullName,
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      coachID: json['coachID'] ?? '',
      startHour: json['startDateTime'] != null
          ? DateFormat('hh:mm a').format(DateTime.parse(json['startDateTime']))
          : '',
      fullName: json['fullName'] ?? '',
    );
  }
}

// جلب المواعيد من السيرفر
Future<List<CalendarEvent>> fetchCoachEvents(String coachID, String date) async {
  final url = Uri.parse(
      'https://darkgray-hummingbird-925566.hostingersite.com/noor/coachViews/getMyEvents.php?coachID=$coachID&date=$date');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => CalendarEvent.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load events');
  }
}

class CoachCalendarScreen extends StatefulWidget {
  const CoachCalendarScreen({super.key});

  @override
  State<CoachCalendarScreen> createState() => _CoachCalendarScreenState();
}

class _CoachCalendarScreenState extends State<CoachCalendarScreen> {
  DateTime selectedDate = DateTime.now();
  List<CalendarEvent> _tasks = [];

  final List<DateTime> dates = List.generate(
    30,
        (index) => DateTime.now().add(Duration(days: index)),
  );

  String? coachID;

  @override
  void initState() {
    super.initState();
    _loadCoachIDAndEvents();
  }

  Future<void> _loadCoachIDAndEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    coachID = prefs.getString('token');
    if (coachID != null) {
      await getMyEvents(selectedDate);
    }
  }

  Future<void> getMyEvents(DateTime date) async {
    if (coachID == null) return;
    final dateStr = DateFormat('yyyy-MM-dd').format(date);

    try {
      List<CalendarEvent> events = await fetchCoachEvents(coachID!, dateStr);
      setState(() {
        _tasks = events;
      });
    } catch (e) {
      setState(() {
        _tasks = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    child: _tasks.isEmpty
                        ? const Center(
                      child: Text(
                        "لا يوجد مواعيد في هذا اليوم",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    )
                        : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) =>
                          _buildTaskCard(_tasks[index]),
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
                builder: (context) => DatesTr(title: ''),
              ),
            );
          }
        },
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
            onTap: () {
              setState(() {
                selectedDate = date;
              });
              getMyEvents(date);
            },
            child: Container(
              width: 72,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: isSelected ? Colors.deepPurple : Colors.transparent),
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
                          color:
                          isSelected ? Colors.deepPurple : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('MMM').format(date),
                        style: TextStyle(
                          fontSize: 14,
                          color: isSelected
                              ? Colors.deepPurple
                              : Colors.grey.shade700,
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

  Widget _buildTaskCard(CalendarEvent task) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "👤 ${task.fullName.isEmpty ? 'بدون اسم' : task.fullName}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  "⏰ ${task.startHour}",
                  style:
                  TextStyle(fontSize: 14, color: Colors.grey.shade800),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
