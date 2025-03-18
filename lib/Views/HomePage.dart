import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key, required this.title});

  final String title;

  @override
  State<HomePageScreen> createState() => HomePageScreenPageState();
}

class HomePageScreenPageState extends State<HomePageScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // خلفية الصفحة باللون الليلكي الفاتح
      backgroundColor: Color(0xFFD1C4E9), // لون الليلكي الفاتح
      appBar: AppBar(
        backgroundColor: Color(0xFF9575CD), // خلفية الشريط العلوي باللون الليلكي الداكن
        title: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // زر Calendar
              _buildCustomButton('Calendar', Color(0xFF9575CD), Icons.calendar_today),
              SizedBox(height: 20),

              // زر Profile
              _buildCustomButton('Profile', Color(0xFFAB8EE8), Icons.account_circle),
              SizedBox(height: 20),

              // زر Add
              _buildCustomButton('Add', Color(0xFFE1BEE7), Icons.add),
            ],
          ),
        ),
      ),
    );
  }

  // دالة لبناء الأزرار بتنسيق حديث وكبير
  Widget _buildCustomButton(String label, Color color, IconData icon) {
    return ElevatedButton(
      onPressed: () {
        // هنا يمكنك إضافة المنطق الذي تود تنفيذه عند الضغط على الزر
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // الخلفية
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 25),  // تكبير حجم الأزرار
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35), // حواف دائرية أكثر بروزًا
        ),
        elevation: 10, // إضافة تأثير الظل أكبر قليلاً
        textStyle: TextStyle(
          fontSize: 20, // تكبير الخط داخل الزر
          fontWeight: FontWeight.bold,  // جعل النص أكثر وضوحًا
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 35,  // تكبير الأيقونة داخل الزر
          ),
          SizedBox(width: 15), // زيادة المسافة بين الأيقونة والنص
          Text(
            label,
            style: TextStyle(
              fontSize: 20, // تكبير الخط داخل الزر
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
