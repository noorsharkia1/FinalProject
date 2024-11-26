import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoachCalendarScreen extends StatefulWidget {
  const CoachCalendarScreen({super.key, required this.title});
  final String title;

  @override
  State<CoachCalendarScreen> createState() => CoachCalendarScreenPageState();
}

class CoachCalendarScreenPageState extends State<CoachCalendarScreen> {
  DateTime selectedDate = DateTime.now();
  List<DateTime> dates = List.generate(
    30, // عدد الأيام في الرزنامة
        (index) => DateTime.now().add(Duration(days: index)),
  );

  // قائمة المهام اليومية المرتبطة بكل تاريخ (مثال بيانات مع اسم العميل والساعة)
  Map<DateTime, List<Task>> dailyTasks = {
    DateTime.now(): [
      Task(customerName: "أحمد", time: "10:00 AM"),
      Task(customerName: "سارة", time: "11:30 AM"),
      Task(customerName: "محمد", time: "2:00 PM"),
    ], // مثال لبعض المهام
    DateTime.now().add(Duration(days: 1)): [
      Task(customerName: "علي", time: "9:00 AM"),
      Task(customerName: "ريم", time: "4:30 PM"),
    ],
  };

  // هذا سيُنفذ عندما يضغط المستخدم على تاريخ
  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  // دالة لحذف مهمة معينة
  void _deleteTask(Task task) {
    setState(() {
      dailyTasks[selectedDate]?.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    // تحويل المهام اليومية الخاصة بالتاريخ المحدد
    List<Task> tasksForSelectedDate = dailyTasks[selectedDate] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'التاريخ المحدد: ${DateFormat('dd MMM yyyy').format(selectedDate)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            DateTimelinePicker(
              dates: dates,
              selectedDate: selectedDate,
              onDateSelected: _onDateSelected,
              selectedDateColor: Colors.blue,
              unselectedDateColor: Colors.grey,
              selectedDateTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              unselectedDateTextStyle: TextStyle(color: Colors.black),
              itemSpacing: 12.0,
              itemHeight: 50.0,
            ),
            SizedBox(height: 20),
            // عرض المهام اليومية لهذا التاريخ داخل أزرار
            Text(
              'المهام اليومية لهذا التاريخ:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // عرض المهام كأزرار يمكن النقر عليها
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: tasksForSelectedDate.map((task) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Colors.blueAccent,
                  ),
                  onPressed: () {
                    // هنا يمكنك إضافة الكود لربط الزر بصفحة أخرى
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('تم الضغط على مهمة: ${task.customerName}')),
                    );
                  },
                  child: Row(
                    children: [
                      // عرض اسم العميل والساعة
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('العميل: ${task.customerName}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          Text('الساعة: ${task.time}', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      // زر تعديل لحذف المهمة
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.white),
                        onPressed: () {
                          _deleteTask(task);
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// هيكل المهمة
class Task {
  final String customerName;
  final String time;

  Task({required this.customerName, required this.time});
}

// الرزنامة مع اختيار التاريخ
class DateTimelinePicker extends StatelessWidget {
  final List<DateTime> dates;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final Color selectedDateColor;
  final Color unselectedDateColor;
  final TextStyle selectedDateTextStyle;
  final TextStyle unselectedDateTextStyle;
  final double itemSpacing;
  final double itemHeight;

  DateTimelinePicker({
    required this.dates,
    required this.selectedDate,
    required this.onDateSelected,
    this.selectedDateColor = Colors.blue,
    this.unselectedDateColor = Colors.grey,
    this.selectedDateTextStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    this.unselectedDateTextStyle = const TextStyle(color: Colors.black),
    this.itemSpacing = 10.0,
    this.itemHeight = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(dates.length, (index) {
          final date = dates[index];
          final isSelected = date.isAtSameMomentAs(selectedDate);

          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: itemSpacing),
              child: Container(
                height: itemHeight,
                decoration: BoxDecoration(
                  color: isSelected ? selectedDateColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected ? selectedDateColor : unselectedDateColor,
                    width: 2,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Center(
                  child: Text(
                    DateFormat('dd MMM').format(date),
                    style: isSelected ? selectedDateTextStyle : unselectedDateTextStyle,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

