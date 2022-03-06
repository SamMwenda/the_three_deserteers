import 'dart:ui';

import 'package:the_three_deserteers/Theme/theme.dart';
import 'package:the_three_deserteers/Values/values.dart';

class ShakyViTheme extends AppTheme {
  const ShakyViTheme() : super();

  @override
  Color get backGroundColor => AppColors.backgroundColor2;

  @override
  int get character => 1;

  @override
  String get characterAnimation => "animations/shaky_vi.riv";

  @override
  Color get foregoundColor => AppColors.foregroundColor2;

  @override
  String get image => "images/characters/shaky_vi.png";

  @override
  String get puzzleShuffle => "shaky_vi";

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
