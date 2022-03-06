import 'package:flutter/material.dart';
import 'package:the_three_deserteers/App/app.dart';

class AppRoute {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return FadeRoute(page: const HomePage());

      

      case '/about':
        return FadeRoute(page: const AboutPage());

        case '/challenge':
        return FadeRoute(page: const ChallengeDetail());


      
      default:
        return FadeRoute(page: const HomePage());
    }
  }
}

///animation to next page
class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
