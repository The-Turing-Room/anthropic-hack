import 'dart:io';

import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:holo_tutor/core/components/brand_text.dart';
import 'package:holo_tutor/core/state.dart';
import 'package:holo_tutor/core/theme/theme.dart';
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

class MainPanel extends ConsumerStatefulWidget {
  const MainPanel({super.key});

  @override
  ConsumerState<MainPanel> createState() => _MainPanelState();
}

class _MainPanelState extends ConsumerState<MainPanel> {
  final _pdfController = PdfViewerController();

  void nextPage() {
    _pdfController.nextPage();
    final state = ref.read(stateProvider);
    state.pdfPage = currentPage;
  }

  void previousPage() {
    _pdfController.previousPage();
    final state = ref.read(stateProvider);
    state.pdfPage = currentPage;
  }

  int get currentPage => _pdfController.pageNumber;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(stateProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: SfPdfViewer.file(
                    File(state.pdfFilePath),
                    // state.pdfBytes,
                    // canShowScrollStatus: false,
                    pageLayoutMode: PdfPageLayoutMode.single,
                    controller: _pdfController,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => previousPage(),
                    child: FaIcon(FontAwesomeIcons.arrowLeft),
                  ),
                  ElevatedButton(
                    onPressed: () => nextPage(),
                    child: FaIcon(FontAwesomeIcons.arrowRight),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
