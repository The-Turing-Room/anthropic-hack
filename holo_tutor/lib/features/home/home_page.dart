import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:holo_tutor/core/components/brand_text.dart';
import 'package:holo_tutor/core/state.dart';
import 'package:holo_tutor/features/tutor/tutor_page.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as pth;

class HomePage extends ConsumerWidget {
  static const String path = '/';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(stateProvider);
    return DropRegion(
      // formats: const [Formats.pdf],
      formats: Formats.standardFormats,
      hitTestBehavior: HitTestBehavior.opaque,
      onDropOver: (DropOverEvent event) async {
        return DropOperation.copy;
      },
      onPerformDrop: (PerformDropEvent event) async {
        print('dropped');
        final item = event.session.items.first;
        item.dataReader!.getFile(Formats.pdf, (file) async {
          final router = GoRouter.of(context);
          print('Got file with name: ${file.fileName}');
          final pdf = await file.readAll();
          state.pdfBytes = pdf;
          print('set pdf');
          // Save pdf to tmp directory
          final tmpDir = await getTemporaryDirectory();
          final pdfPath = pth.join(tmpDir.path, 'lecture1.pdf');
          final pdfFile = File(pdfPath);
          await pdfFile.writeAsBytes(pdf);
          state.pdfFilePath = pdfPath;
          print('Saved pdf to path: $pdfPath');
          router.push(TutorPage.path);
          state.uploadPdf();
        });
      },
      child: Scaffold(
        appBar: AppBar(title: const BrandText()),
        body: const Center(
          child: Text('Drag a PDF file to start'),
        ),
      ),
    );
  }
}
