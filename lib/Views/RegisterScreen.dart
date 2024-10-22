import 'package:finalproject/main.dart';
import 'package:flutter/material.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.title});


  final String title;

  @override
  State<RegisterScreen> createState() => RegisterscreenPageState();
}



class RegisterscreenPageState extends State<RegisterScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Email:", style: TextStyle(fontSize: 20),),

            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: ' Email'
              ),
            ),


            Text("Password:", style: TextStyle(fontSize: 20),),

            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: ' Password'
              ),
            ),


            Text("First name:", style: TextStyle(fontSize: 20),),

            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: ' First name'
              ),
            ),

            Text("Last name:", style: TextStyle(fontSize: 20),),

            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: ' Last name'
              ),
            ),
      TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {},
              child: Text('Register'),
            ),
          ],
        ),

      ),
    );
  }
}
