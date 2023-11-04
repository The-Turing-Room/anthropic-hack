import 'package:flutter/material.dart';
import 'package:holo_tutor/home_page.dart';

void main() {
  runApp(const HoloTutorApp());
}

class HoloTutorApp extends StatelessWidget {
  const HoloTutorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Holo Tutor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
