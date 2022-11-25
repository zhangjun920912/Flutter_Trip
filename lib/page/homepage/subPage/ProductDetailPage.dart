import 'package:flutter/material.dart';

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
    return Container();
    // return WebviewScaffold(
    //   url: "https://www.ctrip.com/?sid=155952&allianceid=4897&ouid=index",
    //   appBar: AppBar(
    //     title: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: titleContent,
    //     ),
    //     iconTheme: const IconThemeData(color: Colors.white),
    //   ),
    //   withZoom: true,
    //   withLocalStorage: true,
    //   withJavascript: true,
    // );
  }
}
