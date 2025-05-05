import 'package:flutter/material.dart';

extension SpaceWidget on Widget {
  spaceH(double height) {
    return SizedBox(
      height: height,
    );
  }

  spaceW(double width) {
    return SizedBox(
      width: width,
    );
  }
}
extension MediaQueryValues on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

}