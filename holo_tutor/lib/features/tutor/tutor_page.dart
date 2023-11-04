import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:holo_tutor/core/components/brand_text.dart';
import 'package:holo_tutor/core/state.dart';
import 'package:holo_tutor/features/chat/chat_ui.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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

class MainPanel extends ConsumerWidget {
  const MainPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppStateNotifier state = ref.watch(stateProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: SfPdfViewer.memory(state.pdfBytes),
                  // child: SfPdfViewer.network(
                  // 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
                  // ),
                ),
              ),
            ),
            const SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}
