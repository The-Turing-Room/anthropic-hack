import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stateProvider = ChangeNotifierProvider((ref) => AppStateNotifier());

class AppStateNotifier extends ChangeNotifier {
  late Uint8List _pdfBytes;
  Uint8List get pdfBytes => _pdfBytes;
  set pdfBytes(Uint8List value) {
    _pdfBytes = value;
    notifyListeners();
  }

  Future<void> uploadPdf() async {}
}
