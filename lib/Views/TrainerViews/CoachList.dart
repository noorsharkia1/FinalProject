import 'dart:ui';
import 'package:flutter/material.dart';

class CoachList extends StatefulWidget {
  final String title;
  const CoachList({super.key, required this.title});

  @override
  State<CoachList> createState() => _CoachListState();
}

class _CoachListState extends State<CoachList> {
  final List<Map<String, String>> coaches = [
    {
      "name": "Alaa Ahmad",
      "Location": "Haifa",
      "Price": "35"
    },
    {
      "name": "Nour Hasan",
      "Location": "Yafa",
      "Price": "13"
    },
    {
      "name": "Omar Zaid",
      "Location": "Haifa",
      "Price": "40"
    },
  ];

  int? primaryCoachIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1F28),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Available Coaches',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E1F28),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: coaches.length,
                  itemBuilder: (context, index) {
                    final coach = coaches[index];
                    final isPrimary = primaryCoachIndex == index;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: _buildCoachCard(
                        index: index,
                        name: coach["name"]!,
                        Location: coach["Location"]!,
                        Price: coach["Price"]!,  // تصحيح هنا لاستخدام "Price" بدلاً من "price"
                        isPrimary: isPrimary,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCoachCard({
    required int index,
    required String name,
    required String Location,
    required String Price,
    required bool isPrimary,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: isPrimary
            ? const LinearGradient(
          colors: [Color(0xFF70D0D0), Color(0xFFB2F7EF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
            : null,
        color: isPrimary ? null : Colors.white.withOpacity(0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
        border: Border.all(
          color: isPrimary ? Colors.transparent : const Color(0xFF70D0D0).withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: isPrimary ? 35 : 30,
                  backgroundColor: isPrimary ? Colors.white : const Color(0xFF70D0D0),
                  child: Icon(
                    Icons.person,
                    color: isPrimary ? const Color(0xFF70D0D0) : Colors.white,
                    size: isPrimary ? 36 : 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: isPrimary ? 20 : 18,
                          fontWeight: FontWeight.bold,
                          color: isPrimary ? Colors.white : const Color(0xFF1E1F28),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        Location,
                        style: TextStyle(
                          fontSize: 14,
                          color: isPrimary ? Colors.white70 : Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        Price,
                        style: TextStyle(
                          fontSize: 13,
                          color: isPrimary ? Colors.white60 : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                isPrimary
                    ? const Icon(Icons.star_rounded, color: Colors.white, size: 28)
                    : ElevatedButton(
                  onPressed: () => _showJoinConfirmation(index),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  ),
                  child: const Text(
                    "Join",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showJoinConfirmation(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Join"),
        content: const Text("Are you sure you want to join this coach?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                primaryCoachIndex = index;
              });
              Navigator.pop(context);
            },
            child: const Text("Yes, Join"),
          ),
        ],
      ),
    );
  }
}
