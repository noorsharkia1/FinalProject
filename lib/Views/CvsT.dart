import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CvsTScreen extends StatefulWidget {
  const CvsTScreen({super.key, required this.title});
  final String title;

  @override
  State<CvsTScreen> createState() => CvsTScreenPageState();
}

class CvsTScreenPageState extends State<CvsTScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // خلفية بيضاء
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent, // لون الخلفية الأزرق
        elevation: 0, // إزالة الظل
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // كتابة السؤال في أعلى الصفحة
            Text(
              'I am a',
              style: TextStyle(
                fontSize: 36, // جعل الخط أكبر
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent, // لون أزرق فاتح
              ),
            ),
            SizedBox(height: 40),

            // أزرار الاختيارات مع تأثيرات حركة عند الضغط
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildChoiceButton('Coach', Colors.blue.shade300, Icons.sports_handball),
                SizedBox(height: 20),
                _buildChoiceButton('Trainer', Colors.green.shade300, Icons.fitness_center),
              ],
            ),
            SizedBox(height: 40),

            // عرض التاريخ الحالي بشكل مبتكر مع تأثير حركة ظهور
            AnimatedContainer(
              duration: Duration(seconds: 2),
              curve: Curves.easeInOut,
              child: Text(
                'Current Date: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة بناء الأزرار مع تأثيرات الحركة
  Widget _buildChoiceButton(String label, Color color, IconData icon) {
    return GestureDetector(
      onTap: () {
        // هنا يمكن تنفيذ الإجراء عند اختيار Coach أو Trainer
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You selected $label')),
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 5), // تأثير الظل عند الضغط
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
