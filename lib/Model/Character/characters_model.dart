import 'package:flutter/material.dart';
import 'package:the_three_deserteers/Values/values.dart';

class CharacterModel {
  final int index;
  final String title;
  final String alias;
  final String description;
  final Color color;
  final String image;
  final String animation;

  CharacterModel(
      {required this.index,
      required this.title,
      required this.alias,
      required this.description,
      required this.image,
      required this.color,
      required this.animation});
}

List<CharacterModel> listOfCharacters = [
  CharacterModel(
      index: 0,
      title: "Waffle Sam",
      alias: "(Big pyhzzle)",
      description:
          "We are almost speechless on this one, The attitude, let us not make him seem so bad though he's a good waffle. He doesn’t have the best social skills but he doesn’t complicate the game. ‘Big pyhzzle only does what Big pyhzzle wants to do’. Well, that is free will for you. Good luck with this one.\n\nNote: To win just arrange the equation to return the value of x",
      animation: "assets/animations/waffle_sam.riv",
      color: AppColors.foregroundColor1,
      image: "assets/images/characters/waffle_sam.png"),
  CharacterModel(
      index: 1,
      title: "Shaky Vi",
      alias: "(The Denominator)",
      description:
          "The 4 time MVP of the Sweet-Tooth math jam lives up to her name with her consistent domination of her opponents. If you are searching for a challenge then she is the perfect partner.\n\nNote: Using Shaky Vi requires you to return the value of x and positions tiles correctly. Use the tile order to confirm if a tile is in its correct position",
      animation: "assets/animations/shaky_vi.riv",
      color: AppColors.foregroundColor2,
      image: "assets/images/characters/shaky_vi.png"),
  CharacterModel(
      index: 2,
      title: "Cup Dize",
      alias: "(Pro Tractor)",
      description:
          "The sweetest cupcake you might have, Cup Dize is just too sweet. He has won the High-Carbs award two consecutive times. If you want to control what equation you get to do then he is your perfect buddy. Life shouldn't be so difficult right? Well, you certainly do live by his code if you believe this.\n\nNote: To win just arrange the equation to return the value of x",
      animation: "assets/animations/cup_dize.riv",
      color: AppColors.foregroundColor3,
      image: "assets/images/characters/cup_dize.png")
];
