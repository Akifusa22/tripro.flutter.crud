import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PdfWebViewScreen extends StatelessWidget {
  final String pdfUrl;

  PdfWebViewScreen({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: WebView(
        initialUrl: 'https://docs.google.com/gview?embedded=true&url=$pdfUrl',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
