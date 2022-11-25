///
///@desc:
///@author: jzhang28
///@date: 2022年06月22 11点34分，Wednesday
///

import 'package:flutter/material.dart';

import '../material/HotelColors.dart';


///字符串颜色值color转换
class ColorUtil {
  static Color string2Color(String? stringColor) {
    if (null == stringColor || stringColor.length == 0) {
      return HotelColors.hotel_main_color;
    }
    if (stringColor.length < 7) {
      return Colors.transparent;
    } else {
      var hexColor = stringColor.replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = hexColor + "FF";
      }
      if (hexColor.length == 8) {
        var opacityValue = hexColor.substring(6, 8);
        var newColorValue = hexColor.substring(0, 6);
        hexColor = opacityValue + newColorValue;
      }
      return Color(int.parse("0x$hexColor"));
    }
  }
}
