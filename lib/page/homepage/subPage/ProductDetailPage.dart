import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';
import 'package:zjflutter_practise/base/utils/ScreenUtil.dart';

class ProductDetailPage extends StatelessWidget {

  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> titleContent = [];
    titleContent.add(const Text(
      '携程旅行网',
      style: TextStyle(color: Colors.white),
    ));
    titleContent.add(Container(
      width: 50.0,
    ));
    return WebViewX(
      height: ScreenUtil.getScreenHeight(),
      width: ScreenUtil.getScreenWidth(),
      initialContent: "https://www.ctrip.com/?sid=155952&allianceid=4897&ouid=index",
    );
  }
}
