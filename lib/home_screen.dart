import 'package:flutter/material.dart';
import 'health_monitor_page.dart'; // Import your HealthMonitor page

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
            fontWeight: FontWeight.bold, // Make text bold
            fontSize: 22,
          ),
        ),
        centerTitle: true, // Center the title
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          employeeTile(context, "Employee 1"),
          employeeTile(context, "Employee 2"),
          employeeTile(context, "Employee 3"),
          employeeTile(context, "Employee 4"),
        ],
      ),
    );
  }

  Widget employeeTile(BuildContext context, String employeeName) {
    return GestureDetector(
      onTap: () {
        if (employeeName == "Employee 1") {
          navigateToHealthMonitor(context);
        }
        // Add navigation for other employees if needed
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.orangeAccent,
            child: Icon(Icons.person, color: Colors.white),
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
