import 'package:flutter/widgets.dart';
import 'package:the_three_deserteers/Helpers/helpers.dart';

class AppTextStyles {
  ///mali thin
  static TextStyle maliThin(BuildContext context, Color color) {
    return TextStyle(
        fontSize: ScreenSize.width(18, context: context),
        fontFamily: 'Mali',
        fontWeight: FontWeight.w100,
        color: color);
  }

  ///mali bold
  static TextStyle maliBold(BuildContext context, Color color,
      {double? active}) {
    return TextStyle(
        fontSize: ScreenSize.width(18 + active!, context: context),
        fontFamily: 'Mali',
        fontWeight: FontWeight.w500,
        color: color);
  }

  ///bangers font
  static TextStyle bangersRegular(BuildContext context, Color color,
      {double? active}) {
    return TextStyle(
        fontSize: ScreenSize.width(48 + active!, context: context),
        fontFamily: 'Bangers',
        color: color);
  }
}
