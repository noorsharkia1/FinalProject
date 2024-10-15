import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Noor Sharkia '),
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
