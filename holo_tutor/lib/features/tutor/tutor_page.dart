import 'package:flutter/material.dart';
import 'package:holo_tutor/core/components/brand_text.dart';
import 'package:holo_tutor/features/chat/chat_ui.dart';

class TutorPage extends StatelessWidget {
  static const String path = '/tutor';
  const TutorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const BrandText()),
      body: const Row(
        children: [
          Expanded(flex: 5, child: MainPanel()),
          Expanded(flex: 2, child: ChatPanel())
        ],
      ),
    );
  }
}

class MainPanel extends StatelessWidget {
  const MainPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(child: Placeholder()),
    );
  }
}
