import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class HealthMonitor extends StatefulWidget {
  const HealthMonitor({Key? key}) : super(key: key);

  @override
  _HealthMonitorState createState() => _HealthMonitorState();
}

class _HealthMonitorState extends State<HealthMonitor> {
  // Static sample data for demonstration
  final Map<String, dynamic> data = {
    'heartRate': 75,
    'temperature': 36.7,
    'location': {
      'latitude': 22.5726,
      'longitude': 88.3639
    },
    'smoke': 'Low',
    'isAlive': true
  };

  Widget _buildHeartRateChart() {
    // Generate simulated heart rate history based on current heart rate
    final heartRate = data['heartRate'];
    List<FlSpot> heartRateSpots = List.generate(10, (index) {
      // Create slight variations around the current heart rate
      final variation = Random().nextInt(20) - 10; // +/- 10 bpm
      return FlSpot(index.toDouble(), (heartRate + variation).toDouble());
    });

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Heart Rate History',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: heartRateSpots,
                    isCurved: true,
                    color: Colors.redAccent,
                    barWidth: 3,
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.redAccent.withOpacity(0.3),
                    ),
                  ),
                ],
                minX: 0,
                maxX: 9,
                minY: (heartRate - 30).toDouble(),
                maxY: (heartRate + 30).toDouble(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            Icons.favorite_border,
            'Heart Rate',
            '${data['heartRate']} bpm',
            Colors.redAccent,
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            Icons.thermostat,
            'Temperature',
            '${data['temperature']} °C',
            Colors.orangeAccent,
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            Icons.location_on,
            'Location',
            '${data['location']['latitude']}, '
                '${data['location']['longitude']}',
            Colors.blueAccent,
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            Icons.smoking_rooms,
            'Smoke Status',
            '${data['smoke']}',
            data['smoke'] == 'High' ? Colors.redAccent : Colors.greenAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "KAVACH",
          style: TextStyle(color:Colors.greenAccent,fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Personal Info Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white, // Dark card color
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/profile_image.jpg'),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Rupali Tripathy",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // White text
                        ),
                      ),
                      Text(
                        "ID: 2111100467",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black, // Lighter text
                        ),
                      ),
                      Text(
                        "Role: Engineer",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Site: Cast House",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),

                          SizedBox(width: 10),
                          Icon(
                            Icons.check_circle,
                            color: Colors.green, // Green color for the verified icon
                            size: 18, // Adjust size if needed
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Heart Rate Chart
            _buildHeartRateChart(),
            const SizedBox(height: 16),

            // Health Info Card
            _buildHealthInfoCard(),
          ],
        ),
      ),
      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Define the action for the button
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.add_alert, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
