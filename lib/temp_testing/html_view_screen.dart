import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HTMLViewScreen extends StatefulWidget {
  const HTMLViewScreen({super.key});

  @override
  State<HTMLViewScreen> createState() => _HTMLViewScreenState();
}

class _HTMLViewScreenState extends State<HTMLViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    _controller.loadFlutterAsset('assets/html_test.html');
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.runJavaScript(
        'https://ajax.googleapis.com/ajax/libs/model-viewer/3.4.0/model-viewer.min.js');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}