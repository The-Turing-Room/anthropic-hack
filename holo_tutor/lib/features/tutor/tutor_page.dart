import 'package:flutter/material.dart';
import 'package:holo_tutor/core/components/brand_text.dart';
import 'package:holo_tutor/features/chat/chat.dart';

class TutorPage extends StatelessWidget {
  static const String path = '/tutor';
  const TutorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('tutor')),
      body: const Row(
        children: [
          Expanded(flex: 4, child: MainPanel()),
          Expanded(flex: 1, child: ChatPanel())
        ],
      ),
    );
  }
}

class MainPanel extends StatelessWidget {
  const MainPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
