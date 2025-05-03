import 'package:finalproject/Utils/ClientConfig.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:finalproject/Views/CoachList.dart' as myViews;
import 'package:finalproject/Views/TrainerProfile.dart';
import 'package:http/http.dart' as http;

class TrainerCalendar extends StatefulWidget {
  final String title;

  const TrainerCalendar({super.key, required this.title});

  @override
  State<TrainerCalendar> createState() => _TrainerCalendarState();
}

final TextEditingController _textstartDate = TextEditingController();
final TextEditingController _text = TextEditingController();

class _TrainerCalendarState extends State<TrainerCalendar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  int _selectedIndex = 1;

  final List<Map<String, String>> trainings = [
    {"title": "Full Body Workout", "time": "Monday • 6:00 PM"},
    {"title": "Cardio Session", "time": "Wednesday • 7:00 AM"},
    {"title": "Yoga Stretch", "time": "Friday • 8:30 AM"},
  ];

  final List<String> availableDates = [
    "Saturday • 5:00 PM",
    "Sunday • 7:30 AM",
    "Tuesday • 6:15 PM",
    "Thursday • 8:00 AM",
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TrainerProfile(title: '',)),
        );
        break;
      case 1:
        break; // Stay on current page
    //   case 2:
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => const myViews.CoachList(title: '',)),
    // );
        break;
    }
  }

  DateTime _parseTrainingTime(String timeStr) {
    final parts = timeStr.split(' • ');
    final day = parts[0];
    final time = parts[1];
    final now = DateTime.now();

    final daysMap = {
      'Sunday': 0,
      'Monday': 1,
      'Tuesday': 2,
      'Wednesday': 3,
      'Thursday': 4,
      'Friday': 5,
      'Saturday': 6,
    };

    final timeParts = time.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1].split(' ')[0]);
    final isPM = time.toLowerCase().contains('pm');

    final parsedHour = isPM && hour != 12 ? hour + 12 : (hour == 12 && !isPM ? 0 : hour);
    final targetWeekday = daysMap[day]!;

    var date = DateTime(now.year, now.month, now.day, parsedHour, minute);
    while (date.weekday % 7 != targetWeekday) {
      date = date.add(const Duration(days: 1));
    }

    return date;
  }

  Future insertUser(BuildContext context, DateTime startDateTime) async {
    var url = "${serverPath}calendarEvents/insertCalendarEvent.php?userID=0&startDateTime=" + startDateTime.toString();
    url = url.replaceAll(" ", "-");
    final response = await http.get(Uri.parse(url));
    print(url);
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
              child: const Text("Cancel", style: TextStyle(color: Color(0xFF4A4A4A))),
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
            ...availableDates.map((date) {
              return ListTile(
                title: Text(
                  date,
                  style: const TextStyle(fontSize: 18, color: Color(0xFF1E1F28)),
                ),
                trailing: const Icon(Icons.add_circle_outline, color: Colors.teal),
                onTap: () {
                  setState(() {
                    trainings.add({"title": "Custom Training", "time": date});
                    insertUser(context, DateTime.now());
                  });
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
                    icon: const Icon(Icons.filter_list, size: 20, color: Color(0xFF1E1F28)),
                    label: const Text('Filter', style: TextStyle(color: Color(0xFF1E1F28))),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
              const Icon(Icons.sports_gymnastics, color: Color(0xFF1E1F28), size: 30),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1F28),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
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
