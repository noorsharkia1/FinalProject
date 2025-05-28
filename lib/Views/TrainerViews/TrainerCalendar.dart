import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/CalendarEvent.dart';
import 'package:finalproject/Utils/ClientConfig.dart';
import 'package:finalproject/Views/TrainerViews/CoachList.dart' as myViews;
import 'package:finalproject/Views/TrainerViews/TrainerProfile.dart';

class TrainerCalendar extends StatefulWidget {
  final String title;

  const TrainerCalendar({super.key, required this.title});

  @override
  State<TrainerCalendar> createState() => _TrainerCalendarState();
}

class _TrainerCalendarState extends State<TrainerCalendar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  List<Map<String, String>> trainings = [];
  List<CalendarEvent> _availableDates = [];
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();

    loadTrainings();
    getAvailableEvents();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> loadTrainings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? encodedTrainings = prefs.getStringList('trainings');
    if (encodedTrainings != null) {
      setState(() {
        trainings = encodedTrainings
            .map((e) => Map<String, String>.from(json.decode(e)))
            .toList();
      });
    }
  }

  Future<void> saveTrainings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> encodedTrainings =
    trainings.map((e) => json.encode(e)).toList();
    await prefs.setStringList('trainings', encodedTrainings);
  }

  Future<void> getAvailableEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? coachID = prefs.getInt('coachID');

    if (coachID == null) return;

    var url = "calendarEvents/getAvailableEvents.php?coachID=$coachID";
    final response = await http.get(Uri.parse(serverPath + url));
    if (response.statusCode == 200) {
      List<CalendarEvent> arr = [];
      for (Map<String, dynamic> i in json.decode(response.body)) {
        arr.add(CalendarEvent.fromJson(i));
      }
      setState(() {
        _availableDates = arr;
      });
    } else {
      // Handle error or empty response
      setState(() {
        _availableDates = [];
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TrainerProfile(title: ''),
          ),
        );
        break;
      case 1:
      // Stay on current page
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const myViews.CoachList(title: ''),
          ),
        );
        break;
    }
  }

  Future insertCalendarEvent(BuildContext context, String startDateTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? coachID = prefs.getInt('coachID');
    String? token = prefs.getString('token');

    if (coachID == null || token == null) return;

    var url = serverPath +
        "calendarEvents/insertCalendarEvent.php?userID=$token&coachID=$coachID&startDateTime=$startDateTime";
    url = url.replaceAll(" ", "-");
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add event to server')),
      );
    }
  }

  void _deleteTraining(int index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Training"),
          content: const Text("Are you sure you want to delete this training?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child:
              const Text("Cancel", style: TextStyle(color: Color(0xFF4A4A4A))),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Delete", style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      setState(() {
        trainings.removeAt(index);
      });
      await saveTrainings();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Training deleted")),
      );
    }
  }

  void _showDatePickerModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white.withOpacity(0.85),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Select a Date',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1F28),
              ),
            ),
            const SizedBox(height: 20),
            ..._availableDates.map((date) {
              return ListTile(
                title: Text(
                  date.startHour,
                  style: const TextStyle(fontSize: 18, color: Color(0xFF1E1F28)),
                ),
                trailing: const Icon(Icons.add_circle_outline, color: Colors.teal),
                onTap: () async {
                  setState(() {
                    trainings.add({
                      "title": "Custom Training",
                      "time": date.startHour,
                    });
                  });
                  await insertCalendarEvent(context, date.startHour);
                  await saveTrainings();
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ],
        );
      },
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white.withOpacity(0.8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Sort Trainings',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1F28),
                ),
              ),
              const SizedBox(height: 15),
              _buildFilterOption(
                icon: Icons.arrow_upward,
                label: "From Oldest to Newest",
                onTap: () {
                  setState(() {
                    trainings.sort((a, b) => _parseTrainingTime(a["time"]!)
                        .compareTo(_parseTrainingTime(b["time"]!)));
                  });
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 10),
              _buildFilterOption(
                icon: Icons.arrow_downward,
                label: "From Newest to Oldest",
                onTap: () {
                  setState(() {
                    trainings.sort((a, b) => _parseTrainingTime(b["time"]!)
                        .compareTo(_parseTrainingTime(a["time"]!)));
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.teal.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.teal),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF1E1F28),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  DateTime _parseTrainingTime(String timeStr) {
    final parts = timeStr.split(' • ');
    final day = parts[0];
    final time = parts[1];
    final now = DateTime.now();

    final daysMap = {
      'Sunday': 7,
      'Monday': 1,
      'Tuesday': 2,
      'Wednesday': 3,
      'Thursday': 4,
      'Friday': 5,
      'Saturday': 6,
    };

    final timeParts = time.split(':');
    int hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1].split(' ')[0]);
    final isPM = time.toLowerCase().contains('pm');

    if (isPM && hour != 12) {
      hour += 12;
    }
    if (!isPM && hour == 12) {
      hour = 0;
    }

    final targetWeekday = daysMap[day]!;
    DateTime date = DateTime(now.year, now.month, now.day, hour, minute);

    while (date.weekday != targetWeekday) {
      date = date.add(const Duration(days: 1));
    }

    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4F3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1F28),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Trainings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E1F28),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _showFilterOptions,
                    icon:
                    const Icon(Icons.filter_list, size: 20, color: Color(0xFF1E1F28)),
                    label: const Text('Filter',
                        style: TextStyle(color: Color(0xFF1E1F28))),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: trainings.length,
                  itemBuilder: (context, index) {
                    final training = trainings[index];
                    return FadeTransition(
                      opacity: _animation,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: _buildGlassTrainingCard(
                          title: training["title"]!,
                          time: training["time"]!,
                          onDelete: () => _deleteTraining(index),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _showDatePickerModal,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Training'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E8B8B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 6,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Coaches',
          ),
        ],
      ),
    );
  }

  Widget _buildGlassTrainingCard({
    required String title,
    required String time,
    required VoidCallback onDelete,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.45),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.teal.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.teal.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.sports_gymnastics,
                  color: Color(0xFF1E1F28), size: 30),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color(0xFF1E1F28),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      time,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
