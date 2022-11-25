///
///@desc:
///@author: jzhang28
///@date: 2022年06月22 11点32分，Wednesday
///


import 'dart:ui';

class ChildPositionAndSize {
  Size? size;
  late Offset offset;

  bool isNull() {
    if (size == null) {
      return true;
    }

    if (size!.width <= 0 || size!.height <= 0) {
      return true;
    }

    return false;
  }

  double left() {
    return offset.dx;
  }

  double right() {
    return offset.dx + size!.width;
  }

  double top() {
    return offset.dy;
  }

  double bottom() {
    return offset.dy + size!.height;
  }

  bool isOverlap(ChildPositionAndSize other) {
    if (other.isNull()) {
      return false;
    }

    if (other.right() < left() ||
        other.left() > right() ||
        other.top() > bottom() ||
        other.bottom() < top()) {
      return false;
    }

    return true;
  }

  ChildPositionAndSize copy(double extraDx, double extraDy) {
    ChildPositionAndSize copy = ChildPositionAndSize();
    copy.offset = Offset(offset.dx + extraDx, offset.dy + extraDy);
    copy.size = Size(size!.width, size!.height);

    return copy;
  }
}
