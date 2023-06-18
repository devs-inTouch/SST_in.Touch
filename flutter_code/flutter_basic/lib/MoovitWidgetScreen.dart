import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MoovitWidgetScreen extends StatefulWidget {
  @override
  _MoovitWidgetScreenState createState() => _MoovitWidgetScreenState();
}

class _MoovitWidgetScreenState extends State<MoovitWidgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moovit Widget'),
      ),
      body: const WebView(
        initialUrl:
            'https://widgets.moovit.com/ws/FE29795C444828E8E0530100007FA444/4979108',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
