import 'package:flutter/material.dart';


class EditedProfile extends StatefulWidget {
  const EditedProfile({super.key, required this.title});


  final String title;

  @override
  State<EditedProfile> createState() => EditedProfilePageState();
}



class EditedProfilePageState extends State<EditedProfile> {
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

          ],
        ),




      ),
    );
  }
}


