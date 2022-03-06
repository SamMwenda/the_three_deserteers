import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:state_groups/state_groups.dart';
import 'package:the_three_deserteers/BLoc/bloc.dart';
import 'package:the_three_deserteers/Commons/commons.dart';
import 'package:the_three_deserteers/Helpers/helpers.dart';

const double padding = 10;
const BorderRadiusGeometry border = BorderRadius.all(Radius.circular(20));
StateGroup<int> mainGroup = StateGroup<int>();

class Tile extends StatefulWidget {
  const Tile(this.num, this.size, this.offset,
      {Key? key,
      AudioPlayerFactory? audioPlayer,
      required this.expression,
      required this.newExpression})
      : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  final AudioPlayerFactory _audioPlayerFactory;

  factory Tile.fromIndices(
    int num,
    double size,
    int x,
    int y,
    String expression,
    String newExpression, {
    Key? key,
  }) {
    return Tile(
        num,
        size,
        Offset(x * (size + padding) + padding * 0.5,
            y * (size + padding) + padding * 0.5),
        key: key,
        expression: expression,
        newExpression: newExpression);
  }

  final int num;
  final double size;
  final Offset offset;
  final String expression;
  final String newExpression;

  @override
  TileState createState() => TileState();
}

class TileState extends State<Tile> with SingleTickerProviderStateMixin {
  TileState();

  Offset? oldOffset;

  late AnimationController _controller;
  late Animation<double> _animation;
  AudioPlayer? _audioPlayer;

  @override
  void didUpdateWidget(Tile oldWidget) {
    oldOffset = oldWidget.offset;
    _controller.forward(from: 0);

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _audioPlayer = widget._audioPlayerFactory()
      ..setAsset('assets/audio/tile_moved.mp3');
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 530));
    _controller.value = 0;
    _animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer?.dispose();
    super.dispose();
  }

  String _tileItem(String text) {
    String dir = 'assets/images';

    if (text == '0') {
      return '$dir/0.png';
    } else if (text == '1') {
      return '$dir/1.png';
    } else if (text == '2') {
      return '$dir/2.png';
    } else if (text == '3') {
      return '$dir/3.png';
    } else if (text == '4') {
      return '$dir/4.png';
    } else if (text == '5') {
      return '$dir/5.png';
    } else if (text == '6') {
      return '$dir/6.png';
    } else if (text == '7') {
      return '$dir/7.png';
    } else if (text == '8') {
      return '$dir/8.png';
    } else if (text == '9') {
      return '$dir/9.png';
    } else if (text == '+') {
      return '$dir/plus.png';
    } else if (text == '-') {
      return '$dir/minus.png';
    } else if (text == '/') {
      return '$dir/div.png';
    } else if (text == '*') {
      return '$dir/multiply.png';
    }

    return "";
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return Transform.translate(
              offset: oldOffset == null
                  ? widget.offset
                  : Offset.lerp(oldOffset, widget.offset, _animation.value)!,
              child: SizedBox(
                height: widget.size,
                width: widget.size,
                child: InkWell(
                  customBorder:
                      const RoundedRectangleBorder(borderRadius: border),
                  splashColor: themeState.theme.backGroundColor,
                  hoverColor: themeState.theme.backGroundColor,
                  highlightColor: themeState.theme.backGroundColor,
                  child: SizedBox(
                    height: widget.size,
                    width: widget.size,
                    child: Center(
                        child: Image.asset(
                            _tileItem(widget.expression[widget.num - 1]),
                            width: widget.size + 50,
                            fit: BoxFit.cover,
                            height: widget.size + 50)),
                  ),
                  onTap: () {
                    mainGroup.notifyAll(widget.num);
                    unawaited(_audioPlayer?.play());
                    setState(() {});
                  },
                ),
              ),
            );
          }),
    );
  }
}
