import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../base/utils/LottieUtil.dart';
import '../../../base/utils/ScreenUtil.dart';

///
///@desc:
///@author: jzhang28
///@date: 2022年06月28 14点42分，Tuesday
///

class CartAnimationPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CartAnimationPageState();

}

class _CartAnimationPageState extends State<CartAnimationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("动画的使用"),
      ),
      body: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.red, width: 0.5)),
        child: LottieUtils.instance?.getLottieAnimationWidgetWithUrl(
            lottiePath: 'https://images3.c-ctrip.com/ztrip/hotel/2022/6/test2.json', animationWidth: ScreenUtil.getScreenWidth() - 20, animationHeight: 170),
      ),
    );
  }

}
