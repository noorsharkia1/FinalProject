import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:finalproject/Views/CoachRegister.dart'; // تأكد من استيراد شاشة CoachRegister
import 'package:finalproject/Views/RegisterScreen.dart'; // تأكد من استيراد شاشة RegisterScreen

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
      backgroundColor: Color(0xFFD1C4E9), // خلفية باللون الليلكي الفاتح
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Color(0xFF9575CD), // اللون الأزرق الليلكي الداكن
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
                color: Color(0xFF9575CD), // اللون الأزرق الليلكي
              ),
            ),
            SizedBox(height: 40),

            // أزرار الاختيارات مع تأثيرات حركة عند الضغط
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildChoiceButton('Coach', Color(0xFF9575CD), Icons.sports_handball, () {
                  // الانتقال إلى شاشة CoachRegister عند الضغط على "Coach"
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CoachRegister(title: 'Coach Register'),
                    ),
                  );
                }),
                SizedBox(height: 20),
                _buildChoiceButton('Trainer', Color(0xFF66BB6A), Icons.fitness_center, () {
                  // الانتقال إلى شاشة RegisterScreen عند الضغط على "Trainer"
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(title: 'Trainer Register'),
                    ),
                  );
                }),
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
  Widget _buildChoiceButton(String label, Color color, IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed, // تنفيذ الإجراء عند الضغط على الزر
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 25), // تكبير الأزرار
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(35), // حواف دائرية
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
            SizedBox(width: 15),
            Text(
              label,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
