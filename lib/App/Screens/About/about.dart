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
                      EdgeInsets.all(ScreenSize.height(10, context: context)),
                  child: Text("Game play",
                      style: TextStyle(
                          fontSize: ScreenSize.height(24, context: context),
                          fontFamily: 'Mali',
                          fontWeight: FontWeight.w500,
                          color: themeState.theme.foregoundColor)),
                ),
                Text(
                    """The game has one simple objective, find the passkey to reveal your price. 
For every challenge, you complete successfully you get to steal a key from one of the deserteers.
Deserteers are key to the game and to have a successful run ensure you understand
them, after all, you get to pick one of them to face a challenge. Some challenges may
require a little more than understanding of the deserteers, don’t worry we have some
hints to help you push through.""",
                    style: TextStyle(
                        fontSize: ScreenSize.height(18, context: context),
                        fontFamily: 'Mali',
                        fontWeight: FontWeight.w500,
                        color: themeState.theme.foregoundColor)),
                Padding(
                  padding:
                      EdgeInsets.all(ScreenSize.height(10, context: context)),
                  child: Text("Hints",
                      style: TextStyle(
                          fontSize: ScreenSize.height(24, context: context),
                          fontFamily: 'Mali',
                          fontWeight: FontWeight.w500,
                          color: themeState.theme.foregoundColor)),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(ScreenSize.height(5, context: context)),
                  child: Text(
                      """.Defiance - “shiva my love, let’s go back. Back to our place, the place we fell in love.
                      sweet house no 2. Remember?”""",
                      style: TextStyle(
                          fontSize: ScreenSize.height(18, context: context),
                          fontFamily: 'Mali',
                          fontWeight: FontWeight.w500,
                          color: themeState.theme.foregoundColor)),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(ScreenSize.height(5, context: context)),
                  child: Text(
                      """. The Storm - As they say when the clouds are forming, and the storm
                       approaches, who better to walk with than a friend.""",
                      style: TextStyle(
                          fontSize: ScreenSize.height(18, context: context),
                          fontFamily: 'Mali',
                          fontWeight: FontWeight.w500,
                          color: themeState.theme.foregoundColor)),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(ScreenSize.height(5, context: context)),
                  child: Text(
                      """. A time may come when you might need to undo your wrongs""",
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
