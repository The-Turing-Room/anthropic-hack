import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:holo_tutor/core/components/brand_text.dart';
import 'package:holo_tutor/core/state.dart';
import 'package:holo_tutor/core/theme/theme.dart';
import 'package:holo_tutor/features/tutor/tutor_page.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

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
        print('dropping');
        print(event.session.items.first.platformFormats);
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
          router.push(TutorPage.path);
        });
      },
      child: Scaffold(
          appBar: AppBar(title: const BrandText()),
          body: const Center(
            child: Text('Drag a PDF file to start'),
          )
          // body: Column(
          // children: [
          // Center(
          //   child: SizedBox(
          //     width: MediaQuery.of(context).size.width * 0.3,
          //     height: MediaQuery.of(context).size.width * 0.3,
          //     child: Card(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8),
          //         side: const BorderSide(
          //           color: AppTheme.primary,
          //           width: 4,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 16),
          // ElevatedButton(onPressed: () {}, child: const Text('UPLOAD PDF'))
          // ],
          // ),
          ),
    );
  }
}
