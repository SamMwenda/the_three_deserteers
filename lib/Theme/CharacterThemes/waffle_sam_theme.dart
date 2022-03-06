import 'dart:ui';

import 'package:the_three_deserteers/Theme/theme.dart';
import 'package:the_three_deserteers/Values/values.dart';

class WaffleSamTheme extends AppTheme {
  const WaffleSamTheme() : super();

  @override
  Color get backGroundColor => AppColors.backgroundColor1;

  @override
  int get character => 0;

  @override
  String get characterAnimation => "animations/waffle_sam.riv";

  @override
  Color get foregoundColor => AppColors.foregroundColor1;

  @override
  String get image => "images/characters/waffle_sam.png";

  @override
  String get puzzleShuffle => "waffle sam";

  @override
  List<Object?> get props => [
        backGroundColor,
        character,
        characterAnimation,
        foregoundColor,
        image,
        puzzleShuffle
      ];
}
