import 'package:flutter/material.dart';
import 'package:holo_tutor/core/components/brand_text.dart';

class HomePage extends StatelessWidget {
  static const String path = '/';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const BrandText()),
    );
  }
}
