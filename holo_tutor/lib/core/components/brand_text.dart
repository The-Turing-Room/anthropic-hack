import 'package:flutter/material.dart';

class BrandText extends StatelessWidget {
  const BrandText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Holo Tutor',
      style: TextStyle(
        fontFamily: 'Oxanium',
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
