import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:the_three_deserteers/BLoc/bloc.dart';
import 'package:the_three_deserteers/Helpers/helpers.dart';
import 'package:the_three_deserteers/Model/model.dart';

// ignore: must_be_immutable
class CharacterDetail extends StatelessWidget {
  CharacterDetail({
    Key? key,
  }) : super(key: key);
  CharacterModel character = listOfCharacters[0];
  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;

    return Align(
      alignment: Alignment.centerLeft,
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        if (state.theme.character == 0) {
          character = listOfCharacters[0];
        } else if (state.theme.character == 1) {
          character = listOfCharacters[1];
        } else if (state.theme.character == 2) {
          character = listOfCharacters[2];
        }
        return Padding(
          padding: EdgeInsets.only(
              top: ScreenSize.height(100, context: context),
              left: ScreenSize.width(100, context: context)),
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 530),
              padding: EdgeInsets.all(ScreenSize.height(10, context: context)),
              height: ScreenSize.height(500, context: context),
              width: ScreenSize.width(500, context: context),
              decoration: BoxDecoration(
                  color: state.theme.foregoundColor,
                  borderRadius: BorderRadius.all(Radius.circular(
                      ScreenSize.height(50, context: context)))),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        key: Key(character.animation),
                        width: ScreenSize.width(200, context: context),
                        height: ScreenSize.width(200, context: context),
                        child: RiveAnimation.asset(
                          character.animation,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(character.title,
                              style: TextStyle(
                                  fontSize:
                                      ScreenSize.height(24, context: context),
                                  fontFamily: 'Mali',
                                  fontWeight: FontWeight.w500,
                                  color: themeState.theme.backGroundColor)),
                          Text("a.k.a",
                              style: TextStyle(
                                  fontSize:
                                      ScreenSize.height(24, context: context),
                                  fontFamily: 'Mali',
                                  fontWeight: FontWeight.w500,
                                  color: themeState.theme.backGroundColor)),
                          Text(character.alias,
                              style: TextStyle(
                                  fontSize:
                                      ScreenSize.height(24, context: context),
                                  fontFamily: 'Mali',
                                  fontWeight: FontWeight.w500,
                                  color: themeState.theme.backGroundColor)),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        EdgeInsets.all(ScreenSize.height(30, context: context)),
                    child: Text(
                      character.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenSize.height(16, context: context),
                          fontFamily: 'Mali',
                          fontWeight: FontWeight.w100,
                          letterSpacing: 1.5,
                          color: themeState.theme.backGroundColor),
                    ),
                  ),
                ],
              )),
        );
      }),
    );
  }
}
