import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';
import 'package:zjflutter_practise/base/utils/ScreenUtil.dart';

class ProductDetailPage extends StatelessWidget {

  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('携程在手 所走就走')
        ),
        body: WebViewX(
          height: ScreenUtil.getScreenHeight(),
          width: ScreenUtil.getScreenWidth(),
          initialContent: "https://www.ctrip.com/?sid=155952&allianceid=4897&ouid=index",
        ));
  }
}
