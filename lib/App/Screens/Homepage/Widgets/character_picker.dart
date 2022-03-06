import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:the_three_deserteers/BLoc/bloc.dart';
import 'package:the_three_deserteers/Commons/commons.dart';
import 'package:the_three_deserteers/Helpers/helpers.dart';
import 'package:the_three_deserteers/Model/model.dart';

class CharacterPicker extends StatefulWidget {
  const CharacterPicker({
    Key? key,
    AudioPlayerFactory? audioPlayer,
  })  : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  _CharacterPickerState createState() => _CharacterPickerState();
}

class _CharacterPickerState extends State<CharacterPicker> {
  AudioPlayer? _audioPlayer;
  AudioPlayer? _audioPlayerSam;
  AudioPlayer? _audioPlayerVi;
  AudioPlayer? _audioPlayerDize;

  @override
  void initState() {
    super.initState();
    _audioPlayerVi = widget._audioPlayerFactory()
      ..setAsset('assets/audio/shaky_vi_default.mp3');
    _audioPlayerDize = widget._audioPlayerFactory()
      ..setAsset('assets/audio/cup_dize_default.mp3');
    _audioPlayerSam = widget._audioPlayerFactory()
      ..setAsset('assets/audio/waffle_sam_default.mp3');
    _audioPlayer = _audioPlayerSam;
  }

  @override
  void dispose() {
    _audioPlayer?.dispose();
    _audioPlayerSam?.dispose();
    _audioPlayerVi?.dispose();
    _audioPlayerDize?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    final activeTheme = themeState.theme;
    double activeSize = ScreenSize.width(200, context: context);
    double inactiveSize = ScreenSize.width(150, context: context);

    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.only(
              bottom: ScreenSize.height(30, context: context),
              right: ScreenSize.width(150, context: context)),
          child: SizedBox(
            height: ScreenSize.width(220, context: context),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(3, (index) {
                  final theme = themeState.themes[index];
                  final isActiveTheme = theme == activeTheme;
                  final size = isActiveTheme ? activeSize : inactiveSize;
                  return Padding(
                    padding:
                        EdgeInsets.all(ScreenSize.width(10, context: context)),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          if (isActiveTheme) {
                            return;
                          }
                          context
                              .read<ThemeBloc>()
                              .add(ThemeChanged(themeIndex: index));

                          if (index == 0) {
                            setState(() => _audioPlayer = _audioPlayerSam);
                            unawaited(_audioPlayer
                                ?.replay()
                                );
                          } else if (index == 1) {
                            setState(() => _audioPlayer = _audioPlayerVi);
                            unawaited(_audioPlayer
                                ?.replay()
                                );
                          } else if (index == 2) {
                            setState(() => _audioPlayer = _audioPlayerDize);
                            unawaited(_audioPlayer
                                ?.replay()
                                );
                          }
                        },
                        child: AnimatedContainer(
                          width: size,
                          height: size,
                          padding: EdgeInsets.all(
                              ScreenSize.height(20, context: context)),
                          decoration: BoxDecoration(
                              color: listOfCharacters[index].color,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  ScreenSize.width(20, context: context)))),
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 350),
                          child: Image.asset(
                            listOfCharacters[index].image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  );
                })),
          ),
        ),
      ),
    );
  }
}
