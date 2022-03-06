import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:the_three_deserteers/App/Screens/Homepage/Widgets/widgets.dart';
import 'package:the_three_deserteers/BLoc/bloc.dart';
import 'package:the_three_deserteers/Commons/commons.dart';
import 'package:the_three_deserteers/Helpers/helpers.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    AudioPlayerFactory? audioPlayer,
  })  : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _color;
  AudioPlayer? _audioPlayer;
  Color currentColor = Colors.white;
  @override
  void initState() {
    super.initState();
    _audioPlayer = widget._audioPlayerFactory()
      ..setAsset('assets/audio/game.mp3');
    _playAudio();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  void _playAudio() async {
    await _audioPlayer?.setLoopMode(LoopMode.one);
    await _audioPlayer?.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;

    _color = ColorTween(
            begin: themeState.theme.backGroundColor,
            end: themeState.theme.backGroundColor)
        .animate(_controller);
    return AnimatedBuilder(
      animation: _color,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          backgroundColor: _color.value,
          body: AudioControlListener(
            audioPlayer: _audioPlayer,
            child: Stack(
              children: [
                //container character description
                CharacterDetail(),
                //contsiner with character play button
                const RiveCharacterButton(),
                //header
                const Header2(),
                // Change character theme
                const CharacterPicker()
              ],
            ),
          ),
        );
      },
    );
  }
}
