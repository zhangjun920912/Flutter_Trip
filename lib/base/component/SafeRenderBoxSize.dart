///
///@desc:
///@author: jzhang28
///@date: 2022年06月22 11点32分，Wednesday
///

import 'dart:math';

import 'package:flutter/cupertino.dart';

/// 安全setSize 保证设置的size满足constraints
mixin SafeRenderBoxSize on RenderBox {
  @override
  @protected
  set size(Size value) {
    super.size = Size(
        max(min(value.width, constraints.maxWidth), constraints.minWidth),
        max(min(value.height, constraints.maxHeight), constraints.minHeight));
  }
}
