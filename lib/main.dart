import 'dart:convert';
import 'package:finalproject/Models/checkLoginModel.dart';
import 'package:finalproject/Utils/ClientConfig.dart'; // تأكد أن هذا يحتوي على تعريف serverPath
import 'package:finalproject/Utils/utils.dart';
import 'package:finalproject/Views/CoachViews/CoachCalendar.dart';
import 'package:finalproject/Views/TrainerViews/TrainerCalendar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:finalproject/Views/RegisterScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
const String serverPath = "https://darkgray-hummingbird-925566.hostingersite.com/noor/";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitSync',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'FitSync Login'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? _selectedType = 'Coach'; // القيمة الابتدائية
  final List<String> _types = ['Coach', 'Trainer'];

  Future<void> checkLogin(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showDialog(context, "Error", "Please enter your Email and Password.");
      return;
    }

    String url = (_selectedType == "Coach")
        ? "login/checkLoginCoach.php?email=$email&password=$password"
        : "login/checkLogin.php?email=$email&password=$password";

    try {
      final response = await http.get(Uri.parse(serverPath + url));
      print("API URL: ${serverPath + url}");
      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        final loginData = checkLoginModel.fromJson(jsonDecode(response.body));

        if (loginData.userID == "0") {
          _showDialog(context, "Error", "Your email or password is wrong.");
        } else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', loginData.userID!);
          await prefs.setString('gender', loginData.gender!);
          await prefs.setString('firstName', loginData.firstName!);

          if (_selectedType == "Coach") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const CoachCalendarScreen()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const TrainerCalendar(title: 'TrainerCalendar')),
            );
          }
        }
      } else {
        _showDialog(context, "Error", "Login failed, please try again.");
      }
    } catch (e) {
      print("Error: $e");
      _showDialog(context, "Error", "An error occurred. Please try again later.");
    }
  }

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK")
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              const Text(
                "User Type:",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select User Type',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                value: _selectedType,
                items: _types
                    .map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email:",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password:",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your password',
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => checkLogin(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: Text('Login', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen(title: "Create New Account")),
                  );
                },
                child: const Text('Create New Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
