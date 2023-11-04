import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:holo_tutor/core/navigation/navigation.dart';

void main() {
  runApp(const HoloTutorApp());
}

class HoloTutorApp extends StatelessWidget {
  const HoloTutorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Holo Tutor',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green.shade300,
          brightness: Brightness.dark,
          surfaceTint: Colors.transparent,
        ),
        useMaterial3: true,
        fontFamily: GoogleFonts.chakraPetch().fontFamily,
      ),
    );
  }
}
