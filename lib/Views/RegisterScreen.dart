import 'dart:ui';
import 'package:finalproject/Utils/ClientConfig.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/Views/TrainerViews/TrainerCalendar.dart'; // تأكد من المسار
import 'package:http/http.dart' as http;


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.title});

  final String title;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _textFirstName = TextEditingController();
  final TextEditingController _textLastName = TextEditingController();
  final TextEditingController _textEmail = TextEditingController();
  final TextEditingController _textPassword = TextEditingController();
  final TextEditingController _textHeight = TextEditingController();
  final TextEditingController _textWeight = TextEditingController();
  final TextEditingController _textGender = TextEditingController();

  // ✅ الزر بس ينضغط بيروح مباشرة للصفحة المطلوبة
  Future insertUserFunc(BuildContext context) async {

    var url = "users/insertUser.php?firstName=" + _textFirstName.text + "&lastName=" + _textLastName.text + "&email=" + _textEmail.text +
    "&password=" + _textPassword.text + "&height=" + _textHeight.text + "&weight=" + _textWeight.text;
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath + url);
    setState(() { });
    Navigator.pop(context);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const TrainerCalendar(title: "Trainer Calendar"),
      ),
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E1F28), Color(0xFFA3E4DB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _glassField("First Name*", _textFirstName),
                  const SizedBox(height: 16),
                  _glassField("Last Name", _textLastName),
                  const SizedBox(height: 16),
                  _glassField("Email*", _textEmail),
                  const SizedBox(height: 16),
                  _glassField("Password*", _textPassword, obscure: true),
                  const SizedBox(height: 16),
                  _glassField("Height", _textHeight),
                  const SizedBox(height: 16),
                  _glassField("Weight", _textWeight),
                  const SizedBox(height: 16),
                  // _glassField("Gender", _textGender),
                  // const SizedBox(height: 30),
                  _glassButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassField(String hint, TextEditingController controller, {bool obscure = false}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white70),
              border: InputBorder.none,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            ),
          ),
        ),
      ),
    );
  }

  Widget _glassButton() {
    return GestureDetector(
      onTap: (){
        insertUserFunc(context);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: const Center(
              child: Text(
                "Register",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
