import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:holo_tutor/core/navigation/navigation.dart';

void main() {
  runApp(const HoloTutorApp());
}

class HoloTutorApp extends StatelessWidget {
  const HoloTutorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'Holo Tutor',
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green.shade300,
            brightness: Brightness.light,
            surfaceTint: Colors.transparent,
          ),
          cardTheme:
              const CardTheme(elevation: 8, clipBehavior: Clip.antiAlias),
          useMaterial3: true,
          fontFamily: GoogleFonts.chakraPetch().fontFamily,
        ),
      ),
    );
  }
}
