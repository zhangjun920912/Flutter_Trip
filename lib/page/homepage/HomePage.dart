import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zjflutter_practise/page/homepage/subPage/ShareDataWidgetPage.dart';

import 'subPage/CartAnimationPage.dart';
import 'subPage/ProductDetailPage.dart';
import 'subPage/ProviderUsePage.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        home:  HomePageDisplayPage(),
        theme:  ThemeData(
          primaryColor: Color(0xFF198CFF),
        ));
  }
}

class HomePageDisplayPage extends StatefulWidget {
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

  Future<Null> _getBatteryLevel() async {
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

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar:  AppBar(
          title:  Text('首页'),
          actions: <Widget>[
             IconButton(
                icon:  Icon(
                  Icons.center_focus_weak,
                  color: Colors.white,
                ),
                onPressed: _getToast),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          margin: EdgeInsets.only(top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  getItemWidget('与native交互', () {
                    _getBattery();
                  }),
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Text(
                      'battery:$_batteryLevel',
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              getItemWidget('加载网页', () {
                _loadWebView();
              }),
              getItemWidget('共享数据InheritedWidget使用', () {
                shareDateWithInheritedWidget();
              }),
              getItemWidget('Provider的使用', () {
                openProviderPage();
              }),
              getItemWidget('购物车动画的使用', () {
                openCartAnimationPage();
              })
            ],
          ),
        ));
  }

  Widget getItemWidget(String btnText, Function callBack) {
    return GestureDetector(
      onTap: () {
        callBack();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Text(
          btnText,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }

  ///打开使用provider的界面
  void openCartAnimationPage() {
    Navigator.push(context,
         MaterialPageRoute(builder: (context) =>  CartAnimationPage()));
  }

  ///打开使用provider的界面
  void openProviderPage() {
    Navigator.push(context,
         MaterialPageRoute(builder: (context) =>  ProviderUsePage()));
  }

  ///使用InheritedWidget实现数据共享
  void shareDateWithInheritedWidget() {
    Navigator.push(context,
         MaterialPageRoute(builder: (context) =>  ShareDataWidgetPage()));
  }

  ///调用Native的方式弹出Toast
  Future<Null> _getToast() async {
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
       MaterialPageRoute(builder: (context) =>  ProductDetailPage()),
    );
  }
}
