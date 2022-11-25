///
///@desc:流布局组件
///@author: jzhang28
///@date: 2022年06月22 11点31分，Wednesday
///


import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import 'ChildPositionAndSize.dart';
import 'SafeRenderBoxSize.dart';



typedef LinesWrapVisibleCallback = void Function(List<int> displayedIndexes);

/// 类似Wrap， 但支持行数， lines默认一行
class LinesWrap extends MultiChildRenderObjectWidget {
  /// 同行内间距
  final double spacing;

  /// 行间距
  final double runSpacing;

  /// 最大行数 默认0：不限制
  final int lines;

  final LinesWrapVisibleCallback? callback;

  LinesWrap(
      {Key? key,
        required List<Widget> children,
        this.callback,
        this.spacing = 4,
        this.runSpacing = 6,
        this.lines = 1})
      : super(key: key, children: children);

  @override
  LinesWrapLayoutBox createRenderObject(BuildContext context) =>
      LinesWrapLayoutBox(spacing, runSpacing, lines, callback);
}

class LinesWrapLayoutBox extends RenderCustomMultiChildLayoutBox
    with SafeRenderBoxSize {
  final double spacing;
  final double runSpacing;
  final int lines;
  final LinesWrapVisibleCallback? callback;
  final List<ChildPositionAndSize> childDataList = [];

  LinesWrapLayoutBox(this.spacing, this.runSpacing, this.lines, this.callback)
      : super(delegate: _EmptyMultiChildLayoutDelegate());

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is LinesWrapLayoutBoxParentData) {
      child.parentData = LinesWrapLayoutBoxParentData();
    }
  }

  @override
  void performLayout() {
    if (childCount == 0) {
      size = constraints.smallest;
      return;
    }
    var maxSize = const Size(0, 0);
    double x = 0.0, y = 0.0;
    int line = 0;
    List<RenderBox> lineOfData = [];
    childDataList.clear();

    List<RenderBox> childrenList = getChildrenAsList();

    for (final child in childrenList) {
      RenderBox value = child;

      final LinesWrapLayoutBoxParentData childParentData =
      value.parentData as LinesWrapLayoutBoxParentData;

      Constraints childConstraints =
      const BoxConstraints(maxWidth: double.infinity, maxHeight: double.infinity);
      if (childParentData.isLine) {
        childConstraints = BoxConstraints(
            maxWidth: double.infinity, maxHeight: maxSize.height);
      }
      if (childParentData.isPrime) {
        childConstraints = BoxConstraints(
            maxWidth: constraints.maxWidth - x,
            maxHeight: constraints.maxHeight - y);
      }
      value.layout(childConstraints, parentUsesSize: true);
      if (lineOfData.isEmpty && childParentData.isSplitLine) {
        childParentData.shouldDisplay = false;
        continue;
      }
      Size childSize = value.size;

      if (lines > 0 && line >= lines) {
        _positionChild(childParentData,const Offset(0, 0), false);
        continue;
      }

      if (childSize.isEmpty) {
        _positionChild(childParentData, const Offset(0, 0), false);
        continue;
      }
      if (x + childSize.width <= constraints.maxWidth) {
        if (lines > 0 && line >= lines) {
          //放不下了
          _positionChild(childParentData,const Offset(0, 0), false);
        } else {
          lineOfData.add(value);
          _positionChild(childParentData, Offset(x, y), true);

          x += childSize.width;
          maxSize = Size(
              max(maxSize.width, x),
              max(maxSize.height,
                  childParentData.offset.dy + childSize.height));
          if (x + spacing < constraints.maxWidth) {
            x += spacing;
          } else {
            line += 1;
            x = 0;
            y = maxSize.height + runSpacing;
            _midAlignment(lineOfData);
            lineOfData = [];
          }
        }
      } else {
        line += 1;
        x = 0;
        y = maxSize.height + runSpacing;
        _midAlignment(lineOfData);
        lineOfData = [];

        if (lines > 0 && line >= lines) {
          _positionChild(childParentData, const Offset(0, 0), false);
        } else {
          Constraints childConstraints = const BoxConstraints(
              maxWidth: double.infinity, maxHeight: double.infinity);
          value.layout(childConstraints, parentUsesSize: true);
          childSize = value.size;

          lineOfData.add(value);
          _positionChild(childParentData, Offset(x, y), true);
          x += spacing + childSize.width;
          maxSize = Size(
              max(maxSize.width, x),
              max(maxSize.height,
                  childParentData.offset.dy + childSize.height));
        }
      }
    }
    _midAlignment(lineOfData);

    final width = max(maxSize.width, constraints.minWidth);
    final height = max(maxSize.height, constraints.minHeight);
    size = Size(
        min(width, constraints.maxWidth), min(height, constraints.maxHeight));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    List<int> displayedIndexes = [];
    visitChildren((child) {
      RenderBox value = child as RenderBox;
      final LinesWrapLayoutBoxParentData childParentData =
      value.parentData as LinesWrapLayoutBoxParentData;
      if (childParentData.shouldDisplay == true) {
        context.paintChild(value, childParentData.offset + offset);
        displayedIndexes.add(childParentData.positionIndex);
      }
    });
    if (callback != null) {
      callback!(displayedIndexes);
    }
  }


  void _positionChild(LinesWrapLayoutBoxParentData childParentData,
      Offset offset, bool display) {
    childParentData.offset = offset;
    childParentData.shouldDisplay = display;
  }

  void _midAlignment(List<RenderBox> lineOfData) {
    if (lineOfData.isEmpty) {
      return;
    }
    double minX = 0;
    double maxX = 0;

    double minY = 0;
    double maxHeight = 0;

    lineOfData.sort((a, b) {
      final LinesWrapLayoutBoxParentData childParentDataA =
      a.parentData as LinesWrapLayoutBoxParentData;

      final LinesWrapLayoutBoxParentData childParentDataB =
      b.parentData as LinesWrapLayoutBoxParentData;
      return childParentDataA.positionIndex
          .compareTo(childParentDataB.positionIndex);
    });

    bool hasFirst = false;
    for (final child in lineOfData) {
      maxHeight = max(maxHeight, child.size.height);

      final LinesWrapLayoutBoxParentData childParentData =
      child.parentData as LinesWrapLayoutBoxParentData;

      if (hasFirst) {
        minX = childParentData.offset.dx;
        minY = childParentData.offset.dy;
        hasFirst = true;
      } else {
        minX = min(minX, childParentData.offset.dx);
        minY = min(minY, childParentData.offset.dy);
      }
      maxX = max(maxX, childParentData.offset.dx + child.size.width);
    }
    ChildPositionAndSize childData = ChildPositionAndSize();
    childData.offset = Offset(minX, minY);
    childData.size = Size(maxX - minX, maxHeight);
    childDataList.add(childData);

    double dx = 0;
    int i = 0;

    for (final child in lineOfData) {
      final LinesWrapLayoutBoxParentData childParentData =
      child.parentData as LinesWrapLayoutBoxParentData;
      bool shouldDisplay = true;
      if (i == lineOfData.length - 1) {
        shouldDisplay = childParentData.isSplitLine;
      }
      childParentData.shouldDisplay = shouldDisplay;
      if (shouldDisplay) {
        childParentData.offset = Offset(dx,
            (maxHeight - child.size.height) / 2 + childParentData.offset.dy);
        dx += spacing + child.size.width;
      }

      i++;
    }
  }
}

class LinesWrapLayoutBoxParentData extends MultiChildLayoutParentData {
  bool shouldDisplay = false;
  bool isPrime = false;
  bool isLine = false;
  int positionIndex = 0;
  bool isSplitLine = false;
}

class _EmptyMultiChildLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {}

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}
