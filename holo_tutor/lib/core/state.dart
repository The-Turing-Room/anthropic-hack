import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http;

final stateProvider = ChangeNotifierProvider((ref) => AppStateNotifier());

class AppStateNotifier extends ChangeNotifier {
  late Uint8List _pdfBytes;
  Uint8List get pdfBytes => _pdfBytes;
  set pdfBytes(Uint8List value) {
    _pdfBytes = value;
    notifyListeners();
  }

  final endpoint = '';

  bool _uploadingPdf = false;
  bool get uploadingPdf => _uploadingPdf;

  Future<void> uploadPdf() async {
    _uploadingPdf = true;
    notifyListeners();
    try {
      var request = http.MultipartRequest('POST', Uri.parse(endpoint));
      request.files.add(http.MultipartFile.fromBytes(
        'pdf',
        pdfBytes,
        filename: 'file.pdf',
        contentType: http.MediaType('application', 'pdf'),
      ));
      var response = await request.send();
    } finally {
      _uploadingPdf = false;
      notifyListeners();
    }
  }
}
