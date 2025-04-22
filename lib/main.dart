import 'package:flutter/material.dart';
import 'package:safetyjacket_app/health_monitor_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black, // Dark background
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black, // Dark app bar
        ),

        iconTheme: IconThemeData(color: Colors.white), // White icons
      ),
      home: HealthMonitor(),
      debugShowCheckedModeBanner: false,
    );
  }
}
