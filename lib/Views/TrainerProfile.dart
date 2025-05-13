import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:finalproject/Views/TrainerCalendar.dart';
// import 'package:finalproject/Views/CoachList.dart' as myViews;

class TrainerProfile extends StatefulWidget {
  const TrainerProfile({super.key, required this.title});
  final String title;

  @override
  State<TrainerProfile> createState() => TrainerProfilePageState();
}

class TrainerProfilePageState extends State<TrainerProfile> {
  final TextEditingController _firstNameController = TextEditingController(text: "أحمد");
  final TextEditingController _lastNameController = TextEditingController(text: "المهندس");
  final TextEditingController _emailController = TextEditingController(text: "ahmed@example.com");
  final TextEditingController _passwordController = TextEditingController(text: "password123");
  final TextEditingController _weightController = TextEditingController(text: "75");
  final TextEditingController _heightController = TextEditingController(text: "175");

  String _gender = 'male';
  int _selectedIndex = 0;

  // Method to handle BottomNavigationBar tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break; // Stay on the current page (TrainerProfile)
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TrainerCalendar(title: 'Trainer Calendar')),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CoachList(title: '',)),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4F3),
      body: SafeArea(
        child: Stack(
          children: [
            // محتوى الصفحة
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E1F28),
                      letterSpacing: 1.4,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildGlassField("First Name*", _firstNameController, 'Enter first name'),
                        _buildGlassField("Last Name*", _lastNameController, 'Enter last name'),
                        _buildGlassField("Email*", _emailController, 'Enter email'),
                        _buildGlassField("Password*", _passwordController, 'Enter password', isPassword: true),
                        _buildGlassField("Weight (kg)*", _weightController, 'Enter weight'),
                        _buildGlassField("Height (cm)*", _heightController, 'Enter height'),
                        const SizedBox(height: 15),
                        _buildGlassDropdown(),
                        const SizedBox(height: 30),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_firstNameController.text.isNotEmpty &&
                                  _lastNameController.text.isNotEmpty &&
                                  _emailController.text.isNotEmpty &&
                                  _passwordController.text.isNotEmpty &&
                                  _weightController.text.isNotEmpty &&
                                  _heightController.text.isNotEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Profile updated successfully!')),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('All fields are required!')),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E8B8B),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              elevation: 8,
                            ),
                            child: const Text(
                              'Update Profile',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // الشريط السفلي (BottomNavigationBar)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
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

  Widget _buildGlassField(String label, TextEditingController controller, String hint,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.teal.withOpacity(0.1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E1F28),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controller,
                  obscureText: isPassword,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Color(0xFF1E1F28)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassDropdown() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.teal.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.teal.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Gender*:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E1F28),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _gender,
                items: const [
                  DropdownMenuItem(child: Text('Male'), value: 'male'),
                  DropdownMenuItem(child: Text('Female'), value: 'female'),
                ],
                onChanged: (value) {
                  setState(() {
                    _gender = value!;
                  });
                },
                decoration: const InputDecoration.collapsed(hintText: ''),
                style: const TextStyle(color: Color(0xFF1E1F28)),
                dropdownColor: Colors.white.withOpacity(0.95),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
