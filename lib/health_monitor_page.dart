import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HealthMonitor extends StatefulWidget {
  const HealthMonitor({Key? key}) : super(key: key);

  @override
  _HealthMonitorState createState() => _HealthMonitorState();
}

class _HealthMonitorState extends State<HealthMonitor> {

  final Color backgroundColor = Color(0xFF2C2C2E); // dark background
  final Color cardColor = Colors.white;
  final Color iconColor = Colors.orangeAccent;


  final databaseRef = FirebaseDatabase.instance.ref();

  String motion="Loading...";
  String gas="Loading...";
  String pulse="Loading...";
  String blinking="Loading...";
  String temperature = "Loading...";
  String humidity = "Loading...";

  @override
  void initState() {
    super.initState();

    void showTempWarning(double temp) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("⚠️ High Temperature"),
          content: Text("Temperature is too high: ${temp.toStringAsFixed(1)} °C"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            )
          ],
        ),
      );
    }

    databaseRef.child("DHT11/data").onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        double dht1Temp = double.tryParse(data['dht1_temp'].toString()) ?? 0;
        double dht2Temp = double.tryParse(data['dht2_temp'].toString()) ?? 0;
        double highest = dht1Temp >= dht2Temp ? dht1Temp : dht2Temp;

        setState(() {
          temperature = "$highest °C";
        });

        if (highest > 30.0) { // Customize the threshold as needed
          showTempWarning(highest);
        }
      }
    });


    // MOTION DETECTION
    databaseRef.child("Motion/data").onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        bool motion1 = data['motion1'] ?? false;
        bool motion2 = data['motion2'] ?? false;
        setState(() {
          motion = (motion1 || motion2) ? "Detected" : "Not Detected";
        });
      }
    });


    // GAS DETECTION
    databaseRef.child("GAS/data").onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        List<String> gasKeys = ['gas1', 'gas2', 'gas3', 'gas4'];
        bool gasDetected = gasKeys.any((key) {
          int value = int.tryParse(data[key].toString()) ?? 0;
          return value > 600; // threshold
        });
        setState(() {
          gas = gasDetected ? "Detected" : "Normal";
        });
      }
    });


    // PULSE
    databaseRef.child("Pulse/data/pulse_bps").onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          pulse = data.toString();
        });
      }
    });

    // BLINKING
    databaseRef.child("BlinkStatus/data/blinking").onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          blinking = data.toString();
        });
      }
    });


    // Get the latest Temperature
    // databaseRef.child("DHT11/Temperature").onValue.listen((event) {
    //   final data = event.snapshot.value as Map<dynamic, dynamic>?;
    //
    //   if (data != null && data.isNotEmpty) {
    //     final lastValue = data.values.last;
    //     setState(() {
    //       temperature = lastValue.toString();
    //     });
    //   }
    // });


    // Get the latest Humidity
    databaseRef.child("DHT11/Humidity").onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null && data.isNotEmpty) {
        final lastValue = data.values.last;
        setState(() {
          humidity = lastValue.toString();
        });
      }
    });
  }
  Widget infoCard(String title, String value, IconData icon) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 30),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: Colors.green,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }





  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "KAVACH",
              style: TextStyle(
                color: Colors.orangeAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage('assets/profile_image.jpg'), // Add your image in assets
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rupali Tripathy",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                        ),
                        Text("ID: 2111100467",style: TextStyle(color: Colors.black),),
                        Text("Role: Engineer",style: TextStyle(color: Colors.black),),
                        Row(
                          children: [
                            Text("Site: Cast House",style: TextStyle(color: Colors.black),),
                            SizedBox(width: 4),
                            Icon(Icons.verified, color: Colors.green, size: 18),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),

            infoCard("Motion", "$motion", FontAwesomeIcons.personWalking),
            infoCard("Gas", "$gas", FontAwesomeIcons.smog),
            infoCard("Pulse", "$pulse", FontAwesomeIcons.heartbeat),
            infoCard("Blinking", "$blinking", FontAwesomeIcons.eye),
            infoCard("Temperature", "$temperature", FontAwesomeIcons.temperatureHigh),
            infoCard("Humidity", "$humidity", FontAwesomeIcons.water),

            SizedBox(height: 20,),

            FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.redAccent,
              child: Icon(Icons.add_alert),
            ),
          ],
        ),
      ),

    );
  }
}