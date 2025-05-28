import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_helper.dart';

class DatesTr extends StatefulWidget {
  const DatesTr({super.key, required this.title});
  final String title;

  @override
  State<DatesTr> createState() => _DatesTrPageState();
}

class _DatesTrPageState extends State<DatesTr> {
  List<Map<String, dynamic>> availableDatesWithTimes = [];

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    final appointments = await DatabaseHelper.instance.getAppointments();
    setState(() {
      availableDatesWithTimes = appointments;
    });
  }

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

        final appointment = {
          'coachID': 1, // غيّر هذا إلى الـ coachID المناسب لك
          'day': DateFormat('yyyy-MM-dd').format(combined), // تاريخ فقط
          'startHour': DateFormat('HH:mm:ss').format(combined), // وقت فقط
        };

        await DatabaseHelper.instance.addAppointment(appointment);
        _loadAppointments();
      }
    }
  }

  Future<void> _removeDate(int id) async {
    await DatabaseHelper.instance.deleteAppointment(id);
    _loadAppointments();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd – hh:mm a');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
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
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
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
                    final appointment = availableDatesWithTimes[index];
                    try {
                      final combined = DateFormat("yyyy-MM-dd HH:mm:ss").parse(
                        "${appointment['day']} ${appointment['startHour']}",
                      );
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.event_available, color: Colors.green),
                          title: Text(
                            dateFormat.format(combined),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeDate(appointment['id']),
                          ),
                        ),
                      );
                    } catch (e) {
                      return ListTile(
                        title: Text('Invalid date format'),
                        subtitle: Text('${appointment['day']} ${appointment['startHour']}'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
