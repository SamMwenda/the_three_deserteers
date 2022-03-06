import 'dart:ui';

import 'package:the_three_deserteers/Theme/theme.dart';
import 'package:the_three_deserteers/Values/values.dart';

class CupDizeTheme extends AppTheme {
  const CupDizeTheme() : super();

  @override
  Color get backGroundColor => AppColors.backgroundColor3;

  @override
  int get character => 2;

  @override
  String get characterAnimation => "animations/cup_dize.riv";

  @override
  Color get foregoundColor => AppColors.foregroundColor3;

  @override
  String get image => "images/characters/cup_dize.png";

  @override
  String get puzzleShuffle => "cup_dize";

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
