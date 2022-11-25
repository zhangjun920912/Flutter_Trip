import 'dart:io';

import 'package:flutter/material.dart';

class ScreenUtil {
  static double _navigationBarHeight = 44.0;
  static double _physicsNavBarHeight = 20;
  static double _screenWidth = 375.0; //默认375 防止setup未被调用 获取到0
  static double _screenHeight = 667.0;
  static double _statusBarHeight = 0.0;
  static double _bottomEdgeInset = 0.0;
  static double _pixelRatio = 1.0;
  static bool _isIPhoneX = false;

  static void setup(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    _screenWidth = screenSize.width;
    _screenHeight = screenSize.height;
    _statusBarHeight = MediaQuery.of(context).padding.top;
    _bottomEdgeInset = MediaQuery.of(context).padding.bottom;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _iPhoneX(context);
  }

  static void setupPhysicsNum(BuildContext context) {
    double statusBar = MediaQuery.of(context).padding.top;
    if(_physicsNavBarHeight < 60){
      _physicsNavBarHeight = _navigationBarHeight + statusBar;
    }
  }

  static double get screenWidth => getScreenWidth();
  static double get screenHeight => getScreenHeight();
  static double get physicsNavBarHeight => _physicsNavBarHeight;
  static double get statusBarHeight => _statusBarHeight;
  static double get navigationBarHeight => _navigationBarHeight;
  static double get appBarHeight => _navigationBarHeight + _statusBarHeight;
  static double get bottomEdgeInset => _bottomEdgeInset;
  static double get pixelRatio => _pixelRatio;
  static double get onePixel => 1 / _pixelRatio;
  static bool get isIPhoneX => _isIPhoneX;

  /// 以 iPhone 6 屏幕宽度(物理像素750px，逻辑像素375)为基准进行缩放
  static double hotelR(double value) {
    final newValue = value * screenWidth / 375;
    return newValue.ceilToDouble();
  }

  /// 只是换了命名
  static double scaleSize(double value) {
    final newValue = value * screenWidth / 375;
    return newValue.ceilToDouble();
  }

  /// 获取屏幕宽度
  static double getScreenWidth() {
    var screenWidth = _screenWidth;
    if (screenWidth == 0 || screenWidth == 0.0) {
      screenWidth = 375.0;
    }
    return screenWidth;
  }

  /// 获取屏幕高度
  static double getScreenHeight() {
    var screenHeight = _screenHeight;
    if (screenHeight == 0 || screenHeight == 0.0) {
      screenHeight = 667.0;
    }
    return screenHeight;
  }

  /// 判断当前屏幕是否是iphoneX
  static _iPhoneX(BuildContext context) {
    if (Platform.isIOS) {
      _isIPhoneX = MediaQuery.of(context).padding.bottom > 0;
    } else {
      _isIPhoneX = false;
    }
  }
}
