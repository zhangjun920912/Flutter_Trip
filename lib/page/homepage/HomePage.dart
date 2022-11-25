import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zjflutter_practise/page/homepage/subPage/ShareDataWidgetPage.dart';

import 'subPage/CartAnimationPage.dart';
import 'subPage/ProductDetailPage.dart';
import 'subPage/ProviderUsePage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: HomePageDisplayPage(),
        theme: ThemeData(
          primaryColor: Color(0xFF198CFF),
        ));
  }
}

class HomePageDisplayPage extends StatefulWidget {
  const HomePageDisplayPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageDisplayPageState();
  }
}

class HomePageDisplayPageState extends State<HomePageDisplayPage> {
  static const platform = const MethodChannel('samples.flutter.io/battery');
  static const platform2 = const MethodChannel('samples.flutter.io/toast');

  // Get battery level.
  String _batteryLevel = 'Unknown battery level.';
  String _networkRequestResult = 'Unknown result.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('首页'),
          actions: <Widget>[
            IconButton(
                icon: const Icon(
                  Icons.center_focus_weak,
                  color: Colors.white,
                ),
                onPressed: _getToast),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          margin: const EdgeInsets.only(top: 12),
          child: Wrap(
            children: getWidgets(),
          ),
        ));
  }

  List<Widget> getWidgets() {
    List<Widget> pageWidgets = [];
    pageWidgets.add(getItemWidget('与native交互', () {
      _getBattery();
    }));
    pageWidgets.add(getItemWidget('加载网页', () {
      _loadWebView();
    }));
    pageWidgets.add(getItemWidget('共享数据InheritedWidget使用', () {
      shareDateWithInheritedWidget();
    }));
    pageWidgets.add(getItemWidget('Provider的使用', () {
      openProviderPage();
    }));
    pageWidgets.add(getItemWidget('购物车动画的使用', () {
      openCartAnimationPage();
    }));
    return pageWidgets;
  }

  Widget getItemWidget(String btnText, Function callBack) {
    return GestureDetector(
      onTap: () {
        callBack();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
        decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Text(
          btnText,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int? result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  ///打开使用provider的界面
  void openCartAnimationPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CartAnimationPage()));
  }

  ///打开使用provider的界面
  void openProviderPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ProviderUsePage()));
  }

  ///使用InheritedWidget实现数据共享
  void shareDateWithInheritedWidget() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ShareDataWidgetPage()));
  }

  ///调用Native的方式弹出Toast
  Future<void> _getToast() async {
    Map<String, String> map = {"flutter": "这是一个来自flutter调用Native端的Toast"};
    await platform2.invokeMethod('getNativeToast', map);
  }

  ///获取电量
  void _getBattery() {
    _getBatteryLevel();
  }

  ///加载网页
  void _loadWebView() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProductDetailPage()),
    );
  }
}
