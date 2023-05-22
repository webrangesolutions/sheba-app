import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewAuth extends StatefulWidget {
  final WebViewController controller;
  const WebViewAuth({super.key, required this.controller});

  @override
  State<WebViewAuth> createState() => _WebViewAuthState();
}

class _WebViewAuthState extends State<WebViewAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(
        controller: widget.controller,
      ),
    );
  }
}
