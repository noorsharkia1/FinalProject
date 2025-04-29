import 'package:finalproject/Views/CoachCalendar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// شاشات ثانية (تأكد إنهم موجودين عندك)
import 'package:finalproject/Views/HomePage.dart';
import 'package:finalproject/Views/EditedProfile.dart';
import 'package:finalproject/Views/RegisterScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noor Sharkia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Noor Sharkia'),
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
  // تعاريف مهمة
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final String serverPath = "http://yourserver.com/"; // غيّر الرابط حسب السيرفر تبعك

  // دالة تسجيل الدخول
  Future<void> checkLogin(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("خطأ"),
          content: Text("يرجى إدخال البريد وكلمة المرور"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("حسنًا"),
            )
          ],
        ),
      );
      return;
    }

    var url = "login/checkLogin.php?email=$email&password=$password";

    try {
      final response = await http.get(Uri.parse(serverPath + url));
      print("API URL: ${serverPath + url}");
      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        // هون ممكن تعمل فحص على البيانات الراجعة لو بدك
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) =>
        //       const HomePageScreen(title: 'Home Page')),

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  const CoachCalendarScreen(title: 'Home Page')),
            );
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("خطأ"),
            content: Text("فشل تسجيل الدخول"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("موافق"),
              )
            ],
          ),
        );
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          icon: Icon(Icons.person),
          color: Colors.purple,
          iconSize: 36.0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  const EditedProfile(title: 'Edited Profile')),
            );
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text(
                "Email:",
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Email'),
              ),
              SizedBox(height: 16),
              Text(
                "Password:",
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Password'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => checkLogin(context),
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const RegisterScreen(title: "New Account")),
                  );
                },
                child: Text('Create New Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
