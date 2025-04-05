import 'package:flutter/material.dart';

class CoachList extends StatefulWidget {
  const CoachList({super.key, required this.title});

  final String title;

  @override
  CoachListState createState() => CoachListState();
}

class CoachListState extends State<CoachList> {
  String _selectedTrainerName = "Trainer 1";
  String _selectedTrainerImage = "assets/trainer1.jpg";
  String _selectedTrainerFirstName = "John";
  String _selectedTrainerLastName = "Doe";
  int _selectedTrainerAge = 30;
  String _selectedTrainerLocation = "New York";

  // المدربين الآخرين
  final List<Map<String, String>> otherTrainers = [
    {
      'name': 'Trainer 2',
      'image': 'assets/trainer2.jpg',
      'firstName': 'Jane',
      'lastName': 'Smith',
      'age': '28',
      'location': 'Los Angeles',
    },
    {
      'name': 'Trainer 3',
      'image': 'assets/trainer3.jpg',
      'firstName': 'Emily',
      'lastName': 'Johnson',
      'age': '32',
      'location': 'Miami',
    },
    {
      'name': 'Trainer 4',
      'image': 'assets/trainer4.jpg',
      'firstName': 'Mike',
      'lastName': 'Williams',
      'age': '35',
      'location': 'Chicago',
    },
  ];

  // لتغيير المدرب
  void _onSelectTrainer(Map<String, String> trainer) {
    setState(() {
      _selectedTrainerName = trainer['name']!;
      _selectedTrainerImage = trainer['image']!;
      _selectedTrainerFirstName = trainer['firstName']!;
      _selectedTrainerLastName = trainer['lastName']!;
      _selectedTrainerAge = int.parse(trainer['age']!);
      _selectedTrainerLocation = trainer['location']!;
    });
  }

  // عرض الـ popup عند الضغط على اسم المدرب
  void _showTrainerDetailsPopup(Map<String, String> trainer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(trainer['name']!),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Age: ${trainer['age']}'),
              Text('Location: ${trainer['location']}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Join"),
              onPressed: () {
                Navigator.of(context).pop();
                _showConfirmationDialog(trainer);
              },
            ),
          ],
        );
      },
    );
  }

  // نافذة التأكيد عند الضغط على "انضمام"
  void _showConfirmationDialog(Map<String, String> trainer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you sure?"),
          content: Text(
              "Are you sure you want to unsubscribe from your current trainer and join ${trainer['name']}?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _selectedTrainerName = trainer['name']!;
                  _selectedTrainerImage = trainer['image']!;
                  _selectedTrainerFirstName = trainer['firstName']!;
                  _selectedTrainerLastName = trainer['lastName']!;
                  _selectedTrainerAge = int.parse(trainer['age']!);
                  _selectedTrainerLocation = trainer['location']!;
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // صورة المدرب الحالي في الأعلى
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(_selectedTrainerImage),
              ),
              SizedBox(height: 20),

              // تفاصيل المدرب الحالي
              Text(
                '$_selectedTrainerFirstName $_selectedTrainerLastName',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'Age: $_selectedTrainerAge',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              Text(
                'Location: $_selectedTrainerLocation',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: 30),

              // المدربين الآخرين
              Text(
                'Other Trainers:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              // عرض صور المدربين الآخرين بشكل أفقي
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: otherTrainers.map((trainer) {
                    return GestureDetector(
                      onTap: () => _showTrainerDetailsPopup(trainer),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(trainer['image']!),
                          ),
                          SizedBox(height: 10),
                          Text(
                            trainer['name']!,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
