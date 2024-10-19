import 'package:flutter/material.dart';


class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key, required this.title});


  final String title;

  @override
  State<HomePageScreen> createState() => HomePageScreenPageState();
}



class HomePageScreenPageState extends State<HomePageScreen> {
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




    ),
    );
  }
}


