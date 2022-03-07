import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:the_three_deserteers/App/app.dart';
import 'package:the_three_deserteers/BLoc/bloc.dart';
import 'package:the_three_deserteers/Routing/app_route.dart';
import 'package:the_three_deserteers/Theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:universal_platform/universal_platform.dart';

export 'Screens/Homepage/homepage.dart';
export 'Screens/About/about.dart';
export 'Screens/Puzzle/Widgets/widgets.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final Timer _timer;
  final AppRoute _route = AppRoute();

  static final audioAssets = [
    'assets/audio/cup_dize_default.mp3',
    'assets/audio/cup_dize_no.mp3',
    'assets/audio/waffle_sam_default.mp3',
    'assets/audio/waffle-sam_no.mp3',
    'assets/audio/waffle_sam_confused.mp3',
    'assets/audio/shaky_vi_default.mp3',
    'assets/audio/tile_moved.mp3',
    'assets/audio/slid_in.mp3',
    'assets/audio/game_won.mp3',
    'assets/audio/success.mp3',
    'assets/audio/game.mp3',
    'assets/audio/fail.mp3',
  ];
  static final animationAssets = [
    'assets/animations/background.riv',
    'assets/animations/characters.riv',
    'assets/animations/cup_dize.riv',
    'assets/animations/cup_dize_convo.riv',
    'assets/animations/home_page_anim.riv',
    'assets/animations/play_button.riv',
    'assets/animations/shaky_vi.riv',
    'assets/animations/shaky_vi_convo.riv',
    'assets/animations/waffle_sam.riv',
    'assets/animations/waffle_sam_convo.riv',
  ];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i <= 9; i++) {
      precacheImage(
        Image.asset('assets/images/$i.png').image,
        context,
      );
    }
    precacheImage(
      Image.asset('assets/images/div.png').image,
      context,
    );
    precacheImage(
      Image.asset('assets/images/multiply.png').image,
      context,
    );
    precacheImage(
      Image.asset('assets/images/plus.png').image,
      context,
    );
    precacheImage(
      Image.asset('assets/images/minus.png').image,
      context,
    );
    precacheImage(
      Image.asset('assets/images/btn_expression.png').image,
      context,
    );
    precacheImage(
      Image.asset('assets/images/tile_order.png').image,
      context,
    );
    precacheImage(
      Image.asset('assets/images/new_problem.png').image,
      context,
    );
    precacheImage(
      Image.asset('assets/images/characters/cup_dize.png').image,
      context,
    );
    precacheImage(
      Image.asset('assets/images/characters/waffle_sam.png').image,
      context,
    );
    precacheImage(
      Image.asset('assets/images/characters/shaky_vi.png').image,
      context,
    );
    precacheImage(
      Image.asset('assets/cupdize/expression.png').image,
      context,
    );
    precacheImage(
      Image.asset('assets/wafflesam/expression.png').image,
      context,
    );
    precacheImage(
      Image.asset('assets/shakyvi/expression.png').image,
      context,
    );
    for (final audioAsset in audioAssets) {
      prefetchToMemory(audioAsset);
    }
    for (final animationAsset in animationAssets) {
      prefetchToMemory(animationAsset);
    }
  }

  /// Prefetches the given [filePath] to memory.
  Future<void> prefetchToMemory(String filePath) async {
    if (UniversalPlatform.isWeb) {
      // We rely on browser caching here. Once the browser downloads the file,
      // the native implementation should be able to access it from cache.
      await http.get(Uri.parse('assets/$filePath'));
      return;
    }
    throw UnimplementedError(
      'The function `prefetchToMemory` is not implemented '
      'for platforms other than Web.',
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(
              themes: const [WaffleSamTheme(), ShakyViTheme(), CupDizeTheme()]),
        ),
        BlocProvider(
          create: (context) => RouteBloc(pages: const [
            HomePage(),
            AboutPage(),
          ]),
        ),
        BlocProvider(
          create: (_) => AudioControlBloc(),
        ),
      ],
      child: MaterialApp(
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
        theme: ThemeData(
          appBarTheme:
              const AppBarTheme(color: Color.fromRGBO(237, 243, 249, 1)),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color.fromRGBO(237, 243, 249, 1),
          ),
        ),
        onGenerateRoute: _route.onGenerateRoute,
        initialRoute: '/',
      ),
    );
  }
}
