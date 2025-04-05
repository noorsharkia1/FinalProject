import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // لإدارة التواريخ بشكل أسهل

class TrainerCalendar extends StatefulWidget {
  const TrainerCalendar({super.key, required this.title});

  final String title;

  @override
  State<TrainerCalendar> createState() => TrainerCalendarPageState();
}

class TrainerCalendarPageState extends State<TrainerCalendar> {
  DateTime _selectedDate = DateTime.now(); // التاريخ الافتراضي هو تاريخ اليوم

  // خريطة تحتوي على المهام المرتبطة بكل تاريخ
  final Map<DateTime, List<String>> _tasksForDate = {
    DateTime(2025, 4, 5): [
      "9:00 AM - Meeting with Client",
      "11:00 AM - Workout Session",
      "1:00 PM - Review Training Program",
      "4:00 PM - Check emails"
    ],
    DateTime(2025, 4, 6): [
      "10:00 AM - Team Meeting",
      "1:00 PM - Check emails",
      "3:00 PM - Plan next workout session",
    ],
    DateTime(2025, 4, 7): [
      "8:00 AM - Morning Run",
      "9:30 AM - One-on-one Client Training",
      "12:00 PM - Lunch Break",
      "2:00 PM - Client Call",
      "4:00 PM - Write Weekly Report"
    ],
    DateTime(2025, 4, 8): [
      "7:00 AM - Yoga Session",
      "10:00 AM - Team Meeting",
      "1:00 PM - Workout Plan Review",
      "3:00 PM - Check emails",
      "5:00 PM - Call with Nutritionist"
    ],
    DateTime(2025, 4, 9): [
      "8:00 AM - Client Assessment",
      "11:00 AM - Review Client Progress",
      "2:00 PM - Break and Relax",
      "4:00 PM - Staff Training",
    ],
    // يمكنك إضافة المزيد من المهام لأيام أخرى هنا
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عرض التاريخ المختار
            Text(
              'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // التقويم الأفقي
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 30, // عرض 30 يومًا للأمام من تاريخ اليوم
                itemBuilder: (context, index) {
                  DateTime date = _selectedDate.subtract(Duration(days: index));
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDate = date; // تغيير التاريخ عند الضغط على اليوم
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _selectedDate.isAtSameMomentAs(date)
                            ? Colors.blueAccent
                            : Colors.transparent,
                        border: Border.all(
                          color: _selectedDate.isAtSameMomentAs(date)
                              ? Colors.blue
                              : Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('dd').format(date),
                            style: TextStyle(
                              color: _selectedDate.isAtSameMomentAs(date)
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat('EEE').format(date),
                            style: TextStyle(
                              color: _selectedDate.isAtSameMomentAs(date)
                                  ? Colors.white
                                  : Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20),

            // عرض المهام لهذا اليوم
            Text(
              'Tasks for ${DateFormat('yyyy-MM-dd').format(_selectedDate)}:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // إظهار المهام المرتبطة بالتاريخ المحدد
            _tasksForDate.containsKey(_selectedDate)
                ? ListView.builder(
              shrinkWrap: true,
              itemCount: _tasksForDate[_selectedDate]!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_tasksForDate[_selectedDate]![index]),
                );
              },
            )
                : Center(child: Text('No tasks for this day')),
          ],
        ),
      ),
    );
  }
}

