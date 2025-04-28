import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'health_monitor_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final databaseRef = FirebaseDatabase.instance.ref();
  String sosStatus = "no"; // default value

  @override
  void initState() {
    super.initState();

    // Listen to SOS status
    databaseRef.child("SOS/data/sos_button").onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          sosStatus = data.toString().toLowerCase();
        });
      }
    });
  }

  void navigateToHealthMonitor(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HealthMonitor()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2C2E),
      appBar: AppBar(
        title: Text(
          "KAVACH",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          employeeTile(context, "Employee 1", sosStatus == "yes"),
          employeeTile(context, "Employee 2", false),
          employeeTile(context, "Employee 3", false),
          employeeTile(context, "Employee 4", false),
        ],
      ),
    );
  }

  Widget employeeTile(BuildContext context, String employeeName, bool danger) {
    return GestureDetector(
      onTap: () {
        if (employeeName == "Employee 1") {
          navigateToHealthMonitor(context);
        }
      },
      child: Card(
        color: danger ? Colors.red : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: danger ? Colors.black : Colors.orangeAccent,
            child: Icon(
              danger ? Icons.warning : Icons.person,
              color: Colors.white,
            ),
          ),
          title: Text(
            employeeName,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
        ),
      ),
    );
  }
}
