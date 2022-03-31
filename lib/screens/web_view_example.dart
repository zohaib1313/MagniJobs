import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  String url;

  WebViewExample(this.url);

  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  int pos = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(index: pos, children: <Widget>[
      WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (value) {
          setState(() {
            pos = 1;
          });
        },
        onPageFinished: (value) {
          setState(() {
            pos = 0;
          });
        },
      ),
      const Center(child: CircularProgressIndicator()),
    ]));
  }
}
