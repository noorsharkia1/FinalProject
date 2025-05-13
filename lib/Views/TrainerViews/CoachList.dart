// import 'dart:ui';
// import 'package:flutter/material.dart';
//
// class CoachList extends StatefulWidget {
//   const CoachList({super.key, required this.title});
//   final String title;
//
//   @override
//   CoachListState createState() => CoachListState();
// }
//
// class CoachListState extends State<CoachList> {
//   String _selectedTrainerName = "John Doe";
//   String _selectedTrainerImage = "assets/trainer1.jpg";
//   String _selectedTrainerFirstName = "John";
//   String _selectedTrainerLastName = "Doe";
//   int _selectedTrainerAge = 30;
//   String _selectedTrainerLocation = "New York";
//
//   Future<List<Map<String, String>>> getTrainers() async {
//     return [
//       {
//         'name': 'John Doe',
//         'image': 'assets/trainer1.jpg',
//         'firstName': 'John',
//         'lastName': 'Doe',
//         'age': '30',
//         'location': 'New York',
//       },
//       {
//         'name': 'Jane Smith',
//         'image': 'assets/trainer2.jpg',
//         'firstName': 'Jane',
//         'lastName': 'Smith',
//         'age': '28',
//         'location': 'Los Angeles',
//       },
//       {
//         'name': 'Emily Johnson',
//         'image': 'assets/trainer3.jpg',
//         'firstName': 'Emily',
//         'lastName': 'Johnson',
//         'age': '32',
//         'location': 'Miami',
//       },
//       {
//         'name': 'Mike Williams',
//         'image': 'assets/trainer4.jpg',
//         'firstName': 'Mike',
//         'lastName': 'Williams',
//         'age': '35',
//         'location': 'Chicago',
//       },
//     ];
//   }
//
//   void _showTrainerDetailsPopup(Map<String, String> trainer) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Colors.white.withOpacity(0.95),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           title: Text(trainer['name']!),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Age: ${trainer['age']}'),
//               Text('Location: ${trainer['location']}'),
//             ],
//           ),
//           actions: [
//             TextButton(
//               child: Text("Close"),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             TextButton(
//               child: Text("Join"),
//               onPressed: () {
//                 setState(() {
//                   _selectedTrainerName = trainer['name']!;
//                   _selectedTrainerImage = trainer['image']!;
//                   _selectedTrainerFirstName = trainer['firstName']!;
//                   _selectedTrainerLastName = trainer['lastName']!;
//                   _selectedTrainerAge = int.parse(trainer['age']!);
//                   _selectedTrainerLocation = trainer['location']!;
//                 });
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         title: Text(widget.title),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Stack(
//         children: [
//           // خلفية بتدرج لوني ناعم
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFFE0F7FA), Color(0xFFE3F2FD)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//
//           // محتوى الصفحة مع تأثير زجاجي
//           FutureBuilder<List<Map<String, String>>>(
//             future: getTrainers(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting)
//                 return Center(child: CircularProgressIndicator());
//
//               if (snapshot.hasError)
//                 return Center(child: Text('Error: ${snapshot.error}'));
//
//               final trainers = snapshot.data!;
//
//               return Center(
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(30),
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                       child: Container(
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.15),
//                           borderRadius: BorderRadius.circular(30),
//                           border: Border.all(color: Colors.white.withOpacity(0.2)),
//                         ),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             CircleAvatar(
//                               radius: 60,
//                               backgroundImage: AssetImage(_selectedTrainerImage),
//                             ),
//                             SizedBox(height: 20),
//                             Text(
//                               '$_selectedTrainerFirstName $_selectedTrainerLastName',
//                               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
//                             ),
//                             Text('Age: $_selectedTrainerAge', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
//                             Text('Location: $_selectedTrainerLocation', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
//                             SizedBox(height: 30),
//                             Text('Choose Another Trainer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
//                             SizedBox(height: 10),
//                             SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Row(
//                                 children: trainers.map((trainer) {
//                                   return GestureDetector(
//                                     onTap: () => _showTrainerDetailsPopup(trainer),
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                                       child: Column(
//                                         children: [
//                                           CircleAvatar(
//                                             radius: 35,
//                                             backgroundImage: AssetImage(trainer['image']!),
//                                           ),
//                                           SizedBox(height: 6),
//                                           Text(
//                                             trainer['name']!,
//                                             style: TextStyle(fontSize: 14, color: Colors.black),
//                                             textAlign: TextAlign.center,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }