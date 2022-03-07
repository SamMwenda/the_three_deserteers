import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:the_three_deserteers/BLoc/bloc.dart';
import 'package:the_three_deserteers/Helpers/helpers.dart';



/// a rive container with character play button similar to [RiveCharacterDescription]
class RiveCharacterButton extends StatefulWidget {
  const RiveCharacterButton({Key? key}) : super(key: key);

  @override
  _RiveCharacterButtonState createState() => _RiveCharacterButtonState();
}

class _RiveCharacterButtonState extends State<RiveCharacterButton>
    with SingleTickerProviderStateMixin {
  /// Tracks if the animation is playing by whether controller is running.

  late Animation animation;
  late AnimationController animationController;
  double sam = 0;
  double vi = 0;
  double dize = 0;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 530),
      vsync: this,
    );

    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(
            bottom: ScreenSize.height(200, context: context),
            right: ScreenSize.width(300, context: context)),
        child: SizedBox(
          height: ScreenSize.height(300, context: context),
          width: ScreenSize.width(300, context: context),
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              if (state.theme.puzzleShuffle == 'waffle sam') {
                sam = 1.0;
                vi = 0.0;
                dize = 0.0;
              } else if (state.theme.puzzleShuffle == 'shaky_vi') {
                sam = 0.0;
                vi = 1.0;
                dize = 0.0;
              } else if (state.theme.puzzleShuffle == 'cup_dize') {
                sam = 0.0;
                vi = 0.0;
                dize = 1.0;
              }

              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap:(){
                    Navigator.pushReplacementNamed(context, "/challenge");
                  },
                  child: Stack(
                    children: [
                      Opacity(
                          opacity: sam,
                          child: FadeTransition(
                              opacity: animationController
                                  .drive(CurveTween(curve: Curves.easeOut)),
                              child: RiveAnimation.asset(
                                  'assets/animations/play_button.riv',
                                  animations: const ["wafflesam"],
                                  placeHolder: Center(
                                      child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              state.theme.backGroundColor)))))),
                      Opacity(
                          opacity: vi,
                          child: FadeTransition(
                              opacity: animationController
                                  .drive(CurveTween(curve: Curves.easeOut)),
                              child: RiveAnimation.asset(
                                  'assets/animations/play_button.riv',
                                  animations: const ["shakyvi"],
                                  placeHolder: Center(
                                      child: Center(
                                          child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(state
                                                      .theme
                                                      .backGroundColor))))))),
                      Opacity(
                          opacity: dize,
                          child: FadeTransition(
                              opacity: animationController
                                  .drive(CurveTween(curve: Curves.easeOut)),
                              child: RiveAnimation.asset(
                                  'assets/animations/play_button.riv',
                                  animations: const ["dize"],
                                  placeHolder: Center(
                                      child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              state.theme.foregoundColor)))))),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
