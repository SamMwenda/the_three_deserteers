import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:the_three_deserteers/Helpers/helpers.dart';

class ChallengeRiveAnimation extends StatefulWidget {
  const ChallengeRiveAnimation(
      {Key? key, required this.animation, required this.theme})
      : super(key: key);
  final String animation;
  final int theme;

  @override
  _ChallengeRiveAnimationState createState() => _ChallengeRiveAnimationState();
}

class _ChallengeRiveAnimationState extends State<ChallengeRiveAnimation> {
  SMITrigger? _tile;
  SMITrigger? _newproblemno;
  SMITrigger? _newproblemyes;
  SMITrigger? _idle;
  String asset = "";

  @override
  void initState() {
    super.initState();
    if (widget.theme == 0) {
      asset = 'assets/animations/waffle_sam_convo.riv';
    } else if (widget.theme == 1) {
      asset = 'assets/animations/shaky_vi_convo.riv';
    } else if (widget.theme == 2) {
      asset = 'assets/animations/cup_dize_convo.riv';
      print(widget.animation);
    }
  }

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'convo');
    artboard.addController(controller!);

    if (widget.theme == 0) {
      _idle = controller.findInput<bool>('idle') as SMITrigger;

      _tile = controller.findInput<bool>('tile') as SMITrigger;
      _newproblemno = controller.findInput<bool>('newproblemno') as SMITrigger;
      _newproblemyes =
          controller.findInput<bool>('newproblemyes') as SMITrigger;
    } else if (widget.theme == 1) {
      _idle = controller.findInput<bool>('idle') as SMITrigger;

      _tile = controller.findInput<bool>('tile') as SMITrigger;
      _newproblemno = controller.findInput<bool>('newproblemno') as SMITrigger;
    } else if (widget.theme == 2) {
      _idle = controller.findInput<bool>('idle') as SMITrigger;

      _tile = controller.findInput<bool>('tile') as SMITrigger;
      _newproblemyes =
          controller.findInput<bool>('newproblemyes') as SMITrigger;
    }
  }

  Stream<String> animationChanged() async* {
    if (widget.animation == 'tile') {
      _tile?.fire();
      yield 'tile';
    } else if (widget.animation == 'newproblemno') {
      _newproblemno?.fire();
      yield 'newproblemno';
    }
    if (widget.animation == 'newproblemyes') {
      _newproblemyes?.fire();
      yield 'newproblemyes';
    } else if(widget.animation == 'idle'){
      _idle?.fire();
      yield 'idle';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: ScreenSize.height(800, context: context),
        width: ScreenSize.width(800, context: context),
        child: StreamBuilder<String>(
            stream: animationChanged(),
            builder: (context, snapshot) {
              return RiveAnimation.asset(
                asset,
                fit: BoxFit.cover,
                onInit: _onRiveInit,
              );
            }),
      ),
    );
  }
}


