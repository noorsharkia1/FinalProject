import 'package:finalproject/Views/CvsT.dart';
import 'package:finalproject/Views/EditedProfile.dart';
import 'package:finalproject/Views/HomePage.dart';
import 'package:finalproject/Views/RegisterScreen.dart';
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

  get child => null;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future checkLogin(BuildContext context) async {

    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //  String? getInfoDeviceSTR = prefs.getString("getInfoDeviceSTR");
    var url = "login/checkLogin.php?userName=" + userName+ "&password=" + password;
    final response = await http.get(Uri.parse(serverPath+ url));
    print(serverPath + url);
    // setState(() { });
    // Navigator.pop(context);

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: IconButton(
          icon: Icon(Icons.person),
          color: Colors.purple,
          splashColor: Colors.white,
          iconSize: 36.0,
          padding: EdgeInsets.all(8.0),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditedProfile(title: 'Edited Profile'))
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Email:",
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: ' Email'),
            ),
            Text(
              "Password:",
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: ' Password'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () { checkLogin(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePageScreen(title: 'Home Page')));

              },
              child: Text('login'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const CvsTScreen(title: "new account")),
                );
              },
              child: Text('create new account'),
            ),

            /*TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),

              child: Text('Home Page'),
            ),*/

           /* TextButton(
                child: Icon(Icons.remove_red_eye_rounded),
                onPressed: () => showDialog(context: context, builder: (BuildContext context){
                  return AlertDialog(
                    content: Text("Whatever Widget"),
                  );
                })
            )*/




            
          ],
        ),
      ),
    );
  }
}
