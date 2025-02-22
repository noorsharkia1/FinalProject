import 'package:finalproject/Models/Client.dart';
import 'package:finalproject/Utils/ClientConfig.dart';
import 'package:finalproject/Utils/utils.dart';
import 'package:finalproject/Views/CoachCalendar.dart';
import 'package:finalproject/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CoachRegister extends StatefulWidget {
  const CoachRegister({super.key, required this.title});

  final String title;

  @override
  State<CoachRegister> createState() => CoachRegisterPageState();
}

class CoachRegisterPageState extends State<CoachRegister> {
  final TextEditingController _textFirstName = new TextEditingController();
  final TextEditingController _textLastName = new TextEditingController();
  final TextEditingController _textPassword = new TextEditingController();

  var _txtFirstName= new TextEditingController();
  var _txtLastName= new TextEditingController();
  var _txtPassword = new TextEditingController();
  var _txtEmail = new TextEditingController();


  void insertUserFunc()
  {
    if(_txtFirstName.text != "" && _txtEmail.text != ""  && _textPassword.text != "")
    {
      var client = new Client();
      client.firstName = _txtFirstName.text;
      client.lastName= _txtLastName.text;
      client.password = _txtPassword.text;
      client.email=_txtEmail.text;
      // in
    }
    else
    {
      var Uti = new Utils();
      Uti.showMyDialog(context, "Required", "first name, password and email is required.");
    }

  }

  @override
  Widget build(BuildContext context) {


    Future insertUser(BuildContext context, String firstName, String lastName) async {
      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      //  String? getInfoDeviceSTR = prefs.getString("getInfoDeviceSTR");
      var url = "users/insertUser.php?firstName=" + firstName + "&lastName=" + lastName;
      final response = await http.get(Uri.parse(serverPath + url));
      // print(serverPath + url);
      setState(() { });
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      Text(
      "First name*:",
      style: TextStyle(fontSize: 20),
    ),
    TextField(
    controller: _textFirstName,
    decoration: InputDecoration(
    border: OutlineInputBorder(), hintText: ' First name'),
    ),
    Text(
    "Last name:",
    style: TextStyle(fontSize: 20),
    ),
    TextField(
    controller: _textLastName,
    decoration: InputDecoration(
    border: OutlineInputBorder(), hintText: ' Last name'),
    ),
    Text(
    "Email*:",
    style: TextStyle(fontSize: 20),
    ),
    TextField(
    decoration: InputDecoration(
    border: OutlineInputBorder(), hintText: ' Email'),
    ),
    Text(
    "Password*:",
    style: TextStyle(fontSize: 20),
    ),
    TextField(
    controller: _textPassword,
    decoration: InputDecoration(
    border: OutlineInputBorder(), hintText: ' Password'),
    ),
      ],
      ),
      ),
    );
  }
}

