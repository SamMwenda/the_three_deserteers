import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

export 'CharacterThemes/character_theme.dart';

abstract class AppTheme extends Equatable {
  const AppTheme();

  /// the selcted character theme
  int get character;

  /// background color
  Color get backGroundColor;

  ///foreground color
  Color get foregoundColor;

  ///image of characters
  String get image;

  ///animation of puzzle
  String get puzzleShuffle;

  ///character animation
  String get characterAnimation;
}
