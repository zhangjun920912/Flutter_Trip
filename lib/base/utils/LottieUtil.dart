import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class LottieUtils {
  // 工厂模式
  factory LottieUtils() => _getInstance()!;

  static LottieUtils? get instance => _getInstance();
  static LottieUtils? _instance;

  LottieUtils._internal();

  static LottieUtils? _getInstance() {
    if (_instance == null) {
      _instance = new LottieUtils._internal();
    }
    return _instance;
  }

  Widget getLottieAnimationWidget({required String lottiePath,bool? looper, double? animationHeight, double? animationWidth, AnimationController? controller, Function(LottieComposition)? onLoaded}) {
    return Lottie.asset(lottiePath, repeat: looper, height: animationHeight, width: animationWidth, controller: controller, onLoaded: onLoaded);
  }

  Widget getLottieAnimationWidgetWithUrl({ required String lottiePath,bool? looper, double? animationHeight, double? animationWidth, AnimationController? controller, Function(LottieComposition)? onLoaded}) {
    return Lottie.network(lottiePath, repeat: looper, height: animationHeight, width: animationWidth, controller: controller, onLoaded: onLoaded);
  }
}
