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
          "Fascinating guy, Who joins a math team and hates math, well this guy. His hate for math can be seen in his reluctance to generate new problems, depending on his mood he might cooperate or give you some bad attitude. He gets confused when questioned about order, what can we say Big pyhzzle doesn't like rules. When it comes to points, he is the most generous use him if you want to get on top of that leaderboard.  ",
      animation: "animations/waffle_sam.riv",
      color: AppColors.foregroundColor1,
      image: "images/characters/waffle_sam.png"),
  CharacterModel(
      index: 1,
      title: "Shaky Vi",
      alias: "(The Denominator)",
      description:
          """Careful with this one, she is as ruthless as she is charming. It is believed
the Destroyer has never been beaten. Legend has it a key was stolen from
her once when she was by her lover's side. Sadly for the victor, he faced
shiva’s lover next. You know what they say about tales... So remember
this one.""",
      animation: "animations/shaky_vi.riv",
      color: AppColors.foregroundColor2,
      image: "images/characters/shaky_vi.png"),
  CharacterModel(
      index: 2,
      title: "Cup Dize",
      alias: "(Pro Tractor)",
      description:
          """Not much is known about the puzzle master other than he poses the hardest
slide puzzle known, shuffled by his great friend the Waffle Sam. Other than his 
mysterious nature Cup Dize is a ruthless deserteer you just don’t want to 
challenge.""",
      animation: "animations/cup_dize.riv",
      color: AppColors.foregroundColor3,
      image: "images/characters/cup_dize.png")
];
