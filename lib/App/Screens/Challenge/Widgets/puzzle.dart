// ignore_for_file: constant_identifier_names
//Mαth∫etΣs
import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:eval_ex/expression.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rive/rive.dart';
import 'package:state_groups/state_groups.dart';
import 'package:the_three_deserteers/App/Screens/Challenge/Widgets/challenge_rive_animation.dart';

import 'package:the_three_deserteers/App/app.dart';
import 'package:the_three_deserteers/BLoc/bloc.dart';
import 'package:the_three_deserteers/Commons/commons.dart';
import 'package:the_three_deserteers/Helpers/helpers.dart';
import 'package:the_three_deserteers/Model/model.dart' as model;

List<int?> puzzlePieces = <int?>[];
int numMoves = 0;

enum PossibleSwap {
  LEFT,
  UP,
  DOWN,
  RIGHT,
}

bool canSwapHoleWithLeft(int holeIndex) => holeIndex % 4 != 0;
bool canSwapHoleWithRight(int holeIndex) => holeIndex % 4 != 3;
bool canSwapHoleWithUp(int holeIndex) => holeIndex >= 4;
bool canSwapHoleWithDown(int holeIndex) => holeIndex <= 11;

void swap(int piece1, int piece2) {
  final int? temp = puzzlePieces[piece1];
  puzzlePieces[piece1] = puzzlePieces[piece2];
  puzzlePieces[piece2] = temp;
}

void swapHoleWithLeft(int holeIndex) => swap(holeIndex, holeIndex - 1);
void swapHoleWithRight(int holeIndex) => swap(holeIndex, holeIndex + 1);
void swapHoleWithUp(int holeIndex) => swap(holeIndex, holeIndex - 4);
void swapHoleWithDown(int holeIndex) => swap(holeIndex, holeIndex + 4);

class ChallengeDetail extends StatefulWidget {
  const ChallengeDetail({
    Key? key,
    AudioPlayerFactory? audioPlayer,
  })  : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State<ChallengeDetail> createState() => _ChallengeDetailState();
}

class _ChallengeDetailState extends SyncState<int, ChallengeDetail> {
  _ChallengeDetailState() : super(mainGroup);
  AudioPlayer? _audioPlayerSlide;
  AudioPlayer? _audioPlayerSuccess;
  AudioPlayer? _audioPlayerSamNo;
  AudioPlayer? _audioPlayerSamConfused;
  AudioPlayer? _audioPlayerDizeNo;
  AudioPlayer? _audioPlayerWin;
  AudioPlayer? _audioPlayerFail;
  AudioPlayer? _audioPlayer;

  String expression = '';
  String answerExpression = "";
  String answerNewExpression = "";
  String badExpression = '';
  late int theme;
  bool success = false;
  late ConfettiController _controller;
  String asset = "";
  final FocusNode _focusNode = FocusNode();

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  void initState() {
    super.initState();
    _audioPlayerSamNo = widget._audioPlayerFactory()
      ..setAsset('assets/audio/waffle_sam_no.mp3');
    _audioPlayerWin = widget._audioPlayerFactory()
      ..setAsset('assets/audio/game_won.mp3');
    _audioPlayerDizeNo = widget._audioPlayerFactory()
      ..setAsset('assets/audio/cup_dize_no.mp3');
    _audioPlayerSuccess = widget._audioPlayerFactory()
      ..setAsset('assets/audio/success.mp3');
    _audioPlayerFail = widget._audioPlayerFactory()
      ..setAsset('assets/audio/fail.mp3');
    _audioPlayerSlide = widget._audioPlayerFactory()
      ..setAsset('assets/audio/slid_in.mp3');
    _audioPlayerSamConfused = widget._audioPlayerFactory()
      ..setAsset('assets/audio/waffle_sam_confused.mp3');
    expression = model.MathProblem.expression();
    Expression exp = Expression(expression);
    try {
      answerExpression = exp.eval()!.ceil(scale: 1).toString();
    } catch (e) {
      badExpression = "Bad expression generated";
    }
    _controller = ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayerSlide?.dispose();
    _audioPlayerSuccess?.dispose();
    _audioPlayerSamNo?.dispose();
    _audioPlayerSamConfused?.dispose();
    _audioPlayerDizeNo?.dispose();
    _audioPlayerWin?.dispose();
    _audioPlayerFail?.dispose();
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  void update(int? numToSwap) {
    if (numToSwap == null) {
      return;
    }
    final int numIndex = puzzlePieces.indexOf(numToSwap);
    final int holeIndex = puzzlePieces.indexOf(null);

    void onSuccess() {
      setState(() {
        numMoves++;
      });
    }

    if (numIndex == holeIndex - 1 &&
        canSwapHoleWithLeft(holeIndex) &&
        !success) {
      swapHoleWithLeft(holeIndex);
      onSuccess();
    } else if (numIndex == holeIndex + 1 &&
        canSwapHoleWithRight(holeIndex) &&
        !success) {
      swapHoleWithRight(holeIndex);
      onSuccess();
    } else if (numIndex == holeIndex - 4 &&
        canSwapHoleWithUp(holeIndex) &&
        !success) {
      swapHoleWithUp(holeIndex);
      onSuccess();
    } else if (numIndex == holeIndex + 4 &&
        canSwapHoleWithDown(holeIndex) &&
        !success) {
      swapHoleWithDown(holeIndex);
      onSuccess();
    }
    Expression exp = Expression(newExpression());
    try {
      answerNewExpression = exp.eval()!.ceil(scale: 1).toString();
    } catch (e) {
      answerNewExpression = "Error!";
    }
    if (theme == 1 &&
        numPiecesInRightPlace() == 15 &&
        answerExpression == answerNewExpression) {
      setState(() {
        _audioPlayer = _audioPlayerWin;
        success = true;
        _controller.play();
      });
      unawaited(_audioPlayer?.replay());
    } else if (theme != 1 && answerExpression == answerNewExpression) {
      setState(() {
        _audioPlayer = _audioPlayerWin;
        success = true;
        _controller.play();
      });
      unawaited(_audioPlayer?.replay());
    }
  }

  // Resets everything and shuffles the tiles with the following algorithm:
  // start sorted and then apply 1000 random shuffles
  void resetAndShuffle() {
    numMoves = 0;
    puzzlePieces = <int?>[
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      null
    ];
    final Random rng = Random();

    final List<PossibleSwap> swaps = <PossibleSwap>[];
    for (int i = 0; i < 1000; i++) {
      swaps.clear();
      final int holeIndex = puzzlePieces.indexOf(null);
      if (canSwapHoleWithLeft(holeIndex)) {
        swaps.add(PossibleSwap.LEFT);
      }
      if (canSwapHoleWithRight(holeIndex)) {
        swaps.add(PossibleSwap.RIGHT);
      }
      if (canSwapHoleWithUp(holeIndex)) {
        swaps.add(PossibleSwap.UP);
      }
      if (canSwapHoleWithDown(holeIndex)) {
        swaps.add(PossibleSwap.DOWN);
      }
      final PossibleSwap chosenSwap = swaps[rng.nextInt(swaps.length)];
      if (chosenSwap == PossibleSwap.LEFT) {
        swapHoleWithLeft(holeIndex);
      } else if (chosenSwap == PossibleSwap.RIGHT) {
        swapHoleWithRight(holeIndex);
      } else if (chosenSwap == PossibleSwap.UP) {
        swapHoleWithUp(holeIndex);
      } else if (chosenSwap == PossibleSwap.DOWN) {
        swapHoleWithDown(holeIndex);
      }
    }
    setState(() {
      _audioPlayer = _audioPlayerSuccess;

      _audioPlayer?.play();

      expression = model.MathProblem.expression();
      Expression exp = Expression(expression);
      answerExpression = exp.eval()!.ceil(scale: 1).toString();
      Expression exp1 = Expression(newExpression());
      try {
        answerNewExpression = exp1.eval()!.ceil(scale: 1).toString();
      } catch (e) {
        answerNewExpression = "Error!";
      }
    });
  }

  String newExpression() {
    String newValue = '';
    int indexOfNull = puzzlePieces.indexOf(null);

    puzzlePieces.remove(null);

    newValue = expression[puzzlePieces[0]! - 1] +
        expression[puzzlePieces[1]! - 1] +
        expression[puzzlePieces[2]! - 1] +
        expression[puzzlePieces[3]! - 1] +
        expression[puzzlePieces[4]! - 1] +
        expression[puzzlePieces[5]! - 1] +
        expression[puzzlePieces[6]! - 1] +
        expression[puzzlePieces[7]! - 1] +
        expression[puzzlePieces[8]! - 1] +
        expression[puzzlePieces[9]! - 1] +
        expression[puzzlePieces[10]! - 1] +
        expression[puzzlePieces[11]! - 1] +
        expression[puzzlePieces[12]! - 1] +
        expression[puzzlePieces[13]! - 1] +
        expression[puzzlePieces[14]! - 1];
    puzzlePieces.insert(indexOfNull, null);

    return newValue;
  }

  int numPiecesInRightPlace() {
    int counter = 0;
    for (int i = 0; i < puzzlePieces.length; i++) {
      if (puzzlePieces[i] == null) {
        continue;
      } else if (i == puzzlePieces[i]! - 1) {
        counter++;
      }
    }
    return counter;
  }

  Widget makeGrid(double size) {
    final List<Widget> cells = <Widget>[];

    for (int i = 0; i < puzzlePieces.length; i++) {
      if (puzzlePieces[i] == null) {
        cells.add(Container());
      } else {
        cells.add(Tile.fromIndices(puzzlePieces[i]!, (size * 0.25) - padding,
            i % 4, i ~/ 4, expression, newExpression(),
            key: Key(puzzlePieces[i].toString())));
      }
    }

    return Padding(
      padding: EdgeInsets.only(left: ScreenSize.width(50, context: context)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: size,
          width: size,
          child: Stack(
            children: cells,
          ),
        ),
      ),
    );
  }

  String animation = 'idle';
  double width = 600.0;
  double height = 600.0;
  bool showTileForVi = false;
  bool waitForAnimation = false;

  void animateWaffleSam(String title) {
    if (title == "new_problem") {
      Random number = Random();
      int newNumber = number.nextInt(10);
      if (newNumber == 1 || newNumber == 5 || newNumber == 8) {
        resetAndShuffle();
        setState(() {
          _audioPlayer = _audioPlayerSuccess;
          unawaited(_audioPlayer?.replay());
          animation = "newproblemyes";
          width = 0;
          height = 0;
          Timer(const Duration(seconds: 2), () {
            setState(() {
              animation = "idle";
            });
          });
        });

        Timer(const Duration(seconds: 2), () {
          setState(() {
            width = 600;
            height = 600;
          });
        });
      } else {
        setState(() {
          _audioPlayer = _audioPlayerSamNo;
          width = 0;
          height = 0;
          animation = "newproblemno";
        });
        unawaited(_audioPlayer?.replay());
        Timer(const Duration(seconds: 2), () {
          setState(() {
            animation = "idle";
            width = 600;
            height = 600;
          });
        });
      }
    } else if (title == "tile_order") {
      setState(() {
        _audioPlayer = _audioPlayerSamConfused;
        animation = "tile";
        width = 0;
        height = 0;
      });
      unawaited(_audioPlayer?.replay());
      Timer(const Duration(seconds: 2), () {
        setState(() {
          animation = "idle";
          width = 600;
          height = 600;
        });
      });
    }
  }

  void animateShakyVi(String title) {
    if (title == "new_problem") {
      setState(() {
        _audioPlayer = _audioPlayerFail;
        width = 0;
        height = 0;
        animation = "newproblemno";
      });
      unawaited(_audioPlayer?.replay());
      Timer(const Duration(seconds: 1), () {
        setState(() {
          animation = "idle";
          width = 600;
          height = 600;
        });
      });
    } else if (title == "tile_order") {
      setState(() {
        waitForAnimation = true;
        if (showTileForVi == false) {
          showTileForVi = true;
        } else {
          showTileForVi = false;
        }
        _audioPlayer = _audioPlayerSlide;
        animation = "tile";
        width = 0;
        height = 0;
      });
      unawaited(_audioPlayer?.replay());
      Timer(const Duration(milliseconds: 1200), () {
        setState(() {
          waitForAnimation = false;
          animation = "idle";
          width = 600;
          height = 600;
        });
      });
    }
  }

  void animateCupdize(String title) {
    if (title == "new_problem") {
      resetAndShuffle();
      setState(() {
        _audioPlayer = _audioPlayerSuccess;
        unawaited(_audioPlayer?.replay());
        width = 0;
        height = 0;
        animation = "newproblemyes";
      });

      Timer(const Duration(seconds: 2), () {
        setState(() {
          animation = "idle";
          width = 600;
          height = 600;
        });
      });
    } else if (title == "tile_order") {
      setState(() {
        _audioPlayer = _audioPlayerDizeNo;
        animation = "tile";
        width = 0;
        height = 0;
      });
      unawaited(_audioPlayer?.replay());
      Timer(const Duration(seconds: 2), () {
        setState(() {
          animation = "idle";
          width = 600;
          height = 600;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    theme = themeState.theme.character;
    if (puzzlePieces.isEmpty) {
      resetAndShuffle();
    }
    var _confetti = ConfettiWidget(
      confettiController: _controller,
      blastDirectionality: BlastDirectionality
          .explosive, // don't specify a direction, blast randomly
      emissionFrequency: 0.05,
      gravity: 0.5,
      shouldLoop: true, // start again as soon as the animation is finished
      colors: const [
        Color.fromRGBO(221, 214, 214, 1.0),
        Color.fromRGBO(109, 69, 70, 1.0),
        Color.fromRGBO(75, 79, 106, 1.0),
        Color.fromRGBO(228, 209, 192, 1.0),
        Color.fromRGBO(54, 65, 81, 1.0),
        Color.fromRGBO(88, 91, 86, 1),
        Color.fromRGBO(245, 240, 206, 1),
        Color.fromRGBO(237, 243, 249, 1),
        Color.fromRGBO(178, 168, 150, 1),
        Color.fromRGBO(177, 175, 189, 1),
      ], // manually specify the colors to be used
      createParticlePath: drawStar, // define a custom shape/path.
    );
    var _characterAnimation = Builder(builder: (context) {
      if (themeState.theme.character == 0) {
        asset = "assets/animations/waffle_sam.riv";
      } else if (themeState.theme.character == 1) {
        asset = "assets/animations/shaky_vi.riv";
      } else if (themeState.theme.character == 2) {
        asset = "assets/animations/cup_dize.riv";
      }
      return SizedBox(
        height: ScreenSize.height(200, context: context),
        width: ScreenSize.width(200, context: context),
        child: RiveAnimation.asset(asset,
            placeHolder: Center(
                child: Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            themeState.theme.backGroundColor))))),
      );
    });
    var _message = Padding(
        padding: EdgeInsets.only(top: ScreenSize.height(50, context: context)),
        child: Text("Yeah\n You Won!!",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: ScreenSize.height(50, context: context),
                fontFamily: 'Bangers',
                color: themeState.theme.backGroundColor)));

    var _button = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
            onTap: () {
              _controller.stop();
              setState(() {
                resetAndShuffle();
                success = false;
                _audioPlayer = _audioPlayerSuccess;
              });
              unawaited(_audioPlayer?.replay());
            },
            child: Container(
                height: ScreenSize.height(80, context: context),
                width: ScreenSize.width(150, context: context),
                decoration: BoxDecoration(
                    color: themeState.theme.backGroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(
                        ScreenSize.height(20, context: context)))),
                child: Center(
                  child: Text("Play again",
                      style: TextStyle(
                          fontSize: ScreenSize.height(24, context: context),
                          fontFamily: 'Bangers',
                          color: themeState.theme.foregoundColor)),
                ))));

    /// navigation arrow to go back to previous page
    var _backNavigationArrow = MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, "/");
          },
          child: Padding(
            padding: EdgeInsets.all(ScreenSize.height(20, context: context)),
            child: Icon(
              Icons.arrow_back_rounded,
              size: ScreenSize.height(50, context: context),
              color: themeState.theme.foregoundColor,
            ),
          )),
    );
//<<<<<<<<<<<<<<<<--------END--------->>>>>>>>>>>>>>>>>>>//

    Widget _buttonImage(String title, String image) {
      return Padding(
        padding: EdgeInsets.only(
            top: ScreenSize.height(20, context: context),
            left: ScreenSize.width(50, context: context)),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              if (themeState.theme.character == 0) {
                animateWaffleSam(title);
              } else if (themeState.theme.character == 1) {
                animateShakyVi(title);
              } else if (themeState.theme.character == 2) {
                animateCupdize(title);
              }
            },
            child: AnimatedContainer(
              height: ScreenSize.height(100, context: context),
              width: ScreenSize.width(200, context: context),
              padding: EdgeInsets.all(ScreenSize.height(20, context: context)),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage(
                        image,
                      )),
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenSize.width(20, context: context)))),
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 350),
            ),
          ),
        ),
      );
    }

    var _playGameWidgets = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _backNavigationArrow,
        Column(
          children: [
            Row(
              children: [
                _buttonImage("new_problem", "assets/images/new_problem.png"),
                Builder(builder: (context) {
                  if (!showTileForVi &&
                      (themeState.theme.character == 0 ||
                          themeState.theme.character == 2)) {
                    return _buttonImage("tile_order", "assets/images/tile_order.png");
                  } else if (showTileForVi) {
                    return _buttonImage(
                        "tile_order", "assets/images/btn_expression.png");
                  } else {
                    return _buttonImage("tile_order", "assets/images/tile_order.png");
                  }
                }),
              ],
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: ScreenSize.height(20, context: context)),
              child: Builder(builder: (context) {
                if (!_focusNode.hasFocus) {
                  FocusScope.of(context).requestFocus(_focusNode);
                }
                return makeGrid(ScreenSize.width(500, context: context));
              }),
            ),
          ],
        ),
        Center(
          child: Stack(
            children: [
              ChallengeRiveAnimation(
                  animation: animation, theme: themeState.theme.character),
              Padding(
                padding: EdgeInsets.only(
                    right: ScreenSize.width(200, context: context),
                    bottom: ScreenSize.height(200, context: context)),
                child: Builder(
                  builder: (context) {
                    String dir = '';
                    if (themeState.theme.character == 0) {
                      dir = 'assets/wafflesam';
                    } else if (themeState.theme.character == 1) {
                      dir = 'assets/shakyvi';
                    } else if (themeState.theme.character == 2) {
                      dir = 'assets/cupdize';
                    }
                    return AnimatedContainer(
                      height: ScreenSize.height(height, context: context),
                      width: ScreenSize.width(width, context: context),
                      padding: EdgeInsets.all(
                          ScreenSize.height(20, context: context)),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                            "$dir/expression.png",
                          )),
                          borderRadius: BorderRadius.all(Radius.circular(
                              ScreenSize.width(20, context: context)))),
                      curve: Curves.decelerate,
                      duration: const Duration(milliseconds: 700),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: ScreenSize.height(130, context: context),
                            left: ScreenSize.width(20, context: context)),
                        child: Stack(
                          children: [
                            Positioned(
                              left: ScreenSize.width(150, context: context),
                              child: AnimatedContainer(
                                curve: Curves.easeInOutBack,
                                duration: const Duration(milliseconds: 1230),
                                child: Builder(builder: (context) {
                                  if (!showTileForVi &&
                                      (themeState.theme.character == 0 ||
                                          themeState.theme.character == 2)) {
                                    return Text(
                                      "Given that x = $answerExpression\n\nMatch the puzzle to return x.\n x = $expression \n\n The current expression is:\n${newExpression()} = $answerNewExpression",
                                      style: TextStyle(
                                          color: !waitForAnimation
                                              ? themeState.theme.backGroundColor
                                              : Colors.transparent,
                                          fontFamily: 'Mali',
                                          fontSize: ScreenSize.height(16,
                                              context: context),
                                          fontWeight: FontWeight.w500),
                                    );
                                  } else if (showTileForVi) {
                                    return Text(
                                      "Tiles correctly placed : ${numPiecesInRightPlace().toString()}\n\n\n Number of moves :${numMoves.toString()}  \n\n\n",
                                      style: TextStyle(
                                          color: !waitForAnimation
                                              ? themeState.theme.backGroundColor
                                              : Colors.transparent,
                                          fontFamily: 'Mali',
                                          fontSize: ScreenSize.height(16,
                                              context: context),
                                          fontWeight: FontWeight.w500),
                                    );
                                  } else {
                                    return Text(
                                      "Given that x = $answerExpression\n\nMatch the puzzle to return x.\n x = $expression \n\n The current expression is:\n${newExpression()} = $answerNewExpression",
                                      style: TextStyle(
                                          color: !waitForAnimation
                                              ? themeState.theme.backGroundColor
                                              : Colors.transparent,
                                          fontFamily: 'Mali',
                                          fontSize: ScreenSize.height(16,
                                              context: context),
                                          fontWeight: FontWeight.w500),
                                    );
                                  }
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );

    var _completedSuccesfully = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _backNavigationArrow,
        SizedBox(width: ScreenSize.width(50, context: context)),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                makeGrid(ScreenSize.width(350, context: context)),
                Center(
                  child: Container(
                      color: Colors.transparent,
                      width: ScreenSize.width(400, context: context),
                      height: ScreenSize.width(350, context: context)),
                ),
              ],
            ),
            Text(
              "\nCorrectly solved \n x = ${newExpression()} = $answerNewExpression \n\n Tiles correctly placed:${numPiecesInRightPlace().toString()}",
              style: TextStyle(
                  color: themeState.theme.foregoundColor,
                  fontFamily: 'Mali',
                  fontSize: ScreenSize.height(20, context: context),
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(
              left: ScreenSize.width(200, context: context),
            ),
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 530),
                padding:
                    EdgeInsets.all(ScreenSize.height(10, context: context)),
                height: ScreenSize.height(500, context: context),
                width: ScreenSize.width(500, context: context),
                decoration: BoxDecoration(
                    color: themeState.theme.foregoundColor,
                    borderRadius: BorderRadius.all(Radius.circular(
                        ScreenSize.height(50, context: context)))),
                child: Stack(children: [
                  Align(alignment: Alignment.topLeft, child: _confetti),
                  Align(alignment: Alignment.topCenter, child: _confetti),
                  Align(alignment: Alignment.topRight, child: _confetti),
                  Column(
                    children: [
                      Align(alignment: Alignment.topCenter, child: _message),
                      Align(
                          alignment: Alignment.center,
                          child: _characterAnimation),
                      Align(alignment: Alignment.bottomCenter, child: _button)
                    ],
                  )
                ])),
          ),
        ),
        SizedBox(width: ScreenSize.width(50, context: context)),
      ],
    );
    return Scaffold(
        backgroundColor: themeState.theme.backGroundColor,
        body: AudioControlListener(
          audioPlayer: _audioPlayer,
          child: Builder(builder: (context) {
            if (!success) {
              return _playGameWidgets;
            } else {
              return _completedSuccesfully;
            }
          }),
        ));
  }
}
