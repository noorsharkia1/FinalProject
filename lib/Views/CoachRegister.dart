import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // مكتبة اختيار الصور
import 'dart:io'; // مكتبة التعامل مع الملفات
// import 'package:http/http.dart' as http;
// import 'package:finalproject/Views/CoachCalendar.dart'; // تأكد من وجود هذا المسار
//
// class CoachRegister extends StatefulWidget {
//   const CoachRegister({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<CoachRegister> createState() => CoachRegisterPageState();
// }
//
// class CoachRegisterPageState extends State<CoachRegister> {
//   final TextEditingController _textFirstName = TextEditingController();
//   final TextEditingController _textLastName = TextEditingController();
//   final TextEditingController _textPassword = TextEditingController();
//   final TextEditingController _textEmail = TextEditingController();
//
//   File? _image; // لتخزين الصورة التي يتم اختيارها
//
//   // دالة لاختيار الصورة
//   Future<void> _pickImage() async {
//     final ImagePicker _picker = ImagePicker();
//     // اختيار الصورة من المعرض
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path); // تخزين الصورة المختارة
//       });
//     }
//   }
//
//   // دالة لإضافة المدرب
//   void insertUserFunc() {
//     if (_textFirstName.text != "" && _textEmail.text != "" && _textPassword.text != "") {
//       // منطق إضافة المدرب
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('First name, password, and email are required.'),
//       ));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               // إدخال اسم المدرب
//               Text(
//                 "First name*: ",
//                 style: TextStyle(fontSize: 20),
//               ),
//               TextField(
//                 controller: _textFirstName,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'First name',
//                 ),
//               ),
//               SizedBox(height: 10),
//
//               // إدخال اسم العائلة
//               Text(
//                 "Last name: ",
//                 style: TextStyle(fontSize: 20),
//               ),
//               TextField(
//                 controller: _textLastName,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Last name',
//                 ),
//               ),
//               SizedBox(height: 10),
//
//               // إدخال البريد الإلكتروني
//               Text(
//                 "Email*: ",
//                 style: TextStyle(fontSize: 20),
//               ),
//               TextField(
//                 controller: _textEmail,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Email',
//                 ),
//               ),
//               SizedBox(height: 10),
//
//               // إدخال كلمة المرور
//               Text(
//                 "Password*: ",
//                 style: TextStyle(fontSize: 20),
//               ),
//               TextField(
//                 controller: _textPassword,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Password',
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // زر اختيار الصورة
//               GestureDetector(
//                 onTap: _pickImage, // عند النقر على الصورة
//                 child: Container(
//                   width: 150,
//                   height: 150,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(75),
//                   ),
//                   child: _image == null
//                       ? Icon(
//                     Icons.camera_alt,
//                     size: 50,
//                     color: Colors.white,
//                   )
//                       : ClipOval(
//                     child: Image.file(
//                       _image!,
//                       fit: BoxFit.cover,
//                       width: 150,
//                       height: 150,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // زر التسجيل
//               TextButton(
//                 style: ButtonStyle(
//                   foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//                 ),
//                 onPressed: () {
//                   // منطق التسجيل هنا
//                   insertUserFunc();
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const CoachCalendarScreen()),
//                   );
//                 },
//                 child: Text('Sign Up'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
