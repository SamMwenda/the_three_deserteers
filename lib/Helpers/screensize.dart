import 'package:flutter/material.dart';

class ScreenSize {
  ///resize width according to screen width
  static double width(double value, {required BuildContext context}) {
    return (value / 1440) * MediaQuery.of(context).size.width;
  }

  ///resize height according to screen height
  static double height(double value, {required BuildContext context}) {
    return (value / 720) * MediaQuery.of(context).size.height;
  }
}
