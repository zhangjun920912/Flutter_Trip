///
///@desc:
///@author: jzhang28
///@date: 2022年06月22 11点03分，Wednesday
///

import 'dart:ui';
import 'package:flutter/cupertino.dart';

class StringUtil {
  /// 计算绘制字符串时占多少行
  static int numberOfLines(String text, TextStyle style, double maxWidth) {
    final span = TextSpan(text: text, style: style);
    final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout(maxWidth: maxWidth);
    List<LineMetrics> lines = tp.computeLineMetrics();
    return lines.length;
  }

  /// 是否是 null 或者空字符串
  static bool isNullOrEmpty(String? str) {
    return str == null || str.isEmpty;
  }

  /// 是否为非空字符串
  static bool isNotEmpty(String? str) {
    return StringUtil.isNullOrEmpty(str);
  }

  ///字符串转int
  static int parseToInt(String str) {
    try {
      if (isNullOrEmpty(str)) return 0;
      return int.parse(str);
    } catch (e) {
      return 0;
    }
  }

  ///字符串转double
  static double parseToDouble(String str) {
    try {
      if (isNullOrEmpty(str)) return 0.0;
      return double.parse(str);
    } catch (e) {
      return 0.0;
    }
  }
}

extension StringExt on String {
  /// 计算文本的宽度
  Size boundingTextSize(TextStyle style,
      {int maxLines = 2 ^ 31, double maxWidth = double.infinity}) {
    if (isEmpty) {
      return Size.zero;
    }
    final TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(text: this, style: style),
        maxLines: maxLines)
      ..layout(maxWidth: maxWidth);
    return textPainter.size;
  }
}
