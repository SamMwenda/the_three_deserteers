import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_three_deserteers/App/Screens/Homepage/Widgets/widgets.dart';
import 'package:the_three_deserteers/BLoc/bloc.dart';
import 'package:the_three_deserteers/Helpers/helpers.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    return Scaffold(
      backgroundColor: themeState.theme.backGroundColor,
      body: Stack(
        children: [
          //header
          const Header2(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenSize.height(20, context: context)),
                  child: Text(
                      "Three deserteers is a creation from team Nisa for the Flutter puzzle hack challenge.",
                      style: TextStyle(
                          fontSize: ScreenSize.height(18, context: context),
                          fontFamily: 'Mali',
                          fontWeight: FontWeight.w500,
                          color: themeState.theme.foregoundColor)),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(ScreenSize.height(30, context: context)),
                  child: Text("Game play",
                      style: TextStyle(
                          fontSize: ScreenSize.height(24, context: context),
                          fontFamily: 'Mali',
                          fontWeight: FontWeight.w500,
                          color: themeState.theme.foregoundColor)),
                ),
                Padding(
                   padding:
                      EdgeInsets.only(left:ScreenSize.width(200, context: context),
                      right: ScreenSize.width(200, context: context)),
                  child: Text(
                      "Given an equation x = 88*467+60+67+08 and x = 41231, your objective is to arrange puzzle pieces in a way that returns the value of x. This can simply be done by arranging the order of the tiles as per the expression that is already equal to the value of x. Use one of the Mαth∫etΣs team members to help you out. Every member has a few simple abilities that may prove handy if you pick them. Some abilities though, increase the game’s difficulty.",
                      textAlign:TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenSize.height(18, context: context),
                          fontFamily: 'Mali',
                          fontWeight: FontWeight.w500,
                          color: themeState.theme.foregoundColor)),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenSize.height(50, context: context)),
                  child: Text("We hope you Enjoy our slide puzzle",
                      style: TextStyle(
                          fontSize: ScreenSize.width(48, context: context),
                          fontFamily: 'Bangers',
                          color: themeState.theme.foregoundColor)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
