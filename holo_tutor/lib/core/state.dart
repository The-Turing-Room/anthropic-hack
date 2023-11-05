import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http;

final stateProvider = ChangeNotifierProvider((ref) => AppStateNotifier());

class AppStateNotifier extends ChangeNotifier {
  late Uint8List _pdfBytes;
  late String _pdfFilePath;
  set pdfFilePath(String value) {
    _pdfFilePath = value;
    notifyListeners();
  }

  int pdfPage = 1;

  Uint8List get pdfBytes => _pdfBytes;
  set pdfBytes(Uint8List value) {
    _pdfBytes = value;
    notifyListeners();
  }

  final endpoint = 'http://localhost:5000/publish_pdf/';

  bool _uploadingPdf = false;
  bool get uploadingPdf => _uploadingPdf;

  Future<void> uploadPdf() async {
    _uploadingPdf = true;
    notifyListeners();
    try {
      final response = await http.post(
        Uri.parse(endpoint),
        body: jsonEncode({'file_path': _pdfFilePath}),
      );

      if (response.statusCode == 200) {
        print('PDF published successfully');
      } else {
        print('Failed to publish PDF');
      }
      // Send post request
      // var request = http.MultipartRequest('POST', Uri.parse(endpoint));
      // request.files.add(http.MultipartFile.fromBytes(
      //   'file',
      //   pdfBytes,
      //   filename: 'lecture1.pdf',
      //   contentType: http.MediaType('application', 'pdf'),
      // ));
      // var response = await request.send();
      print('PDF upload status code: ${response.statusCode}');
      // if (response.statusCode == 200) {
      //   print(await response.stream.bytesToString());
      // }
    } finally {
      _uploadingPdf = false;
      notifyListeners();
    }
  }
}
