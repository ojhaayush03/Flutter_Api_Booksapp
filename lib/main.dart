// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services_screen.dart';

// The main entry point of the application
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(), // Root of the app wrapped in ProviderScope for Riverpod state management
    ),
  );
}

// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Services App', // Title of the app displayed in the task manager
      theme: ThemeData(
        primarySwatch: Colors.blue, // Sets the primary theme color of the app
      ),
      home: const ServicesScreen(), // Sets ServicesScreen as the default screen
    );
  }
}
