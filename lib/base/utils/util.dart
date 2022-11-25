///
///@desc:
///@author: jzhang28
///@date: 2022年06月22 11点28分，Wednesday
///

import 'dart:io';
import 'dart:convert' as convert;

class Util {

  ///IOS 平台
  static bool isIOS() {
    return Platform.isIOS;
  }

  ///android平台
  static bool isAndroid() {
    return Platform.isAndroid;
  }

  ///是否空字符串
  static bool isEmptyString(String str) {
    return str.isEmpty;
  }

  /// 是否为非空字符串
  static bool isNotEmptyString(String? str) {
    if (str == null || str is String == false) {
      return false;
    }

    return str.isNotEmpty;
  }

  ///是否空List
  static bool isEmptyList(List list) {
    return list.isEmpty;
  }

  ///是否空map
  static bool isEmptyMap(Map map) {
    return map.isEmpty;
  }

  ///返回当前时间戳
  static int currentTimeMillis() {
    return DateTime.now().millisecondsSinceEpoch; //单位毫秒，13位时间戳
  }

  ///去掉浮点数多余的0 5.10-> 5.1
  static String subZeroAndDot(String str) {
    if (isEmptyString(str)) {
      return "";
    }
    var regExp = RegExp(r'(:\.0*|(\.\d+)0+)$');
    return str.replaceAll(regExp, ""); // 去掉多余的0
  }

  ///叠加新的fromPage统计
  static genFromPage(String sourceFromPage, String fromPage) {
    return isEmptyString(sourceFromPage);
  }

  ///jsonDecode
  static Map? getDecodeJson(String data) {
    if (data == null) return null;
    try {
      return convert.jsonDecode(data);
    } on Exception {
      return null;
    }
  }

}
