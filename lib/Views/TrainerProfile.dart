import 'package:flutter/material.dart';

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

  String _gender = 'male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              // First Name
              Text(
                "First name*:",
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter first name',
                ),
              ),

              // Last Name
              Text(
                "Last name*:",
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter last name',
                ),
              ),

              // Email
              Text(
                "Email*:",
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter email',
                ),
              ),

              // Password
              Text(
                "Password*:",
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter password',
                ),
              ),

              // Gender
              Text(
                "Gender*:",
                style: TextStyle(fontSize: 20),
              ),
              DropdownButtonFormField<String>(
                value: _gender,
                items: [
                  DropdownMenuItem(child: Text('Male'), value: 'male'),
                  DropdownMenuItem(child: Text('Female'), value: 'female'),
                ],
                onChanged: (value) {
                  setState(() {
                    _gender = value!;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),

              // Save Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate inputs and show a confirmation message
                    if (_firstNameController.text.isNotEmpty &&
                        _lastNameController.text.isNotEmpty &&
                        _emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Profile updated successfully!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('All fields are required!')),
                      );
                    }
                  },
                  child: Text('Update Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
