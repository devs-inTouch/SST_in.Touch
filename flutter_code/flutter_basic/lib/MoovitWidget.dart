import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MoovitWidget extends StatelessWidget {
  final String htmlCode = '''
    <script>(function(d, s, id) {
      var js, fjs = d.getElementsByTagName(s)[0];
      var ro = !!d.getElementById(id);
      js = d.createElement(s); js.id = id;
      js.src = "https://widgets.moovit.com/ws/FE29795C444828E8E0530100007FA444/4979108";
      fjs.parentNode.insertBefore(js, fjs);
    })(document, 'script', 'moovit-jsw');</script>
    
    <div class="mv-gd-widget-20" 
         data-width="100%" 
         data-height="100%"
         data-id="4979108"></div>
  ''';

  const MoovitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'about:blank',
      onWebViewCreated: (WebViewController controller) {
        controller.loadUrl(Uri.dataFromString(
          htmlCode,
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        ).toString());
      },
    );
  }
}
