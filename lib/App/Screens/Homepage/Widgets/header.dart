import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_three_deserteers/BLoc/bloc.dart';
import 'package:the_three_deserteers/Helpers/screensize.dart';
import 'package:the_three_deserteers/Typography/textstyles.dart';

class Header2 extends StatefulWidget {
  const Header2({Key? key}) : super(key: key);

  @override
  _Header2State createState() => _Header2State();
}

class _Header2State extends State<Header2> {
  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    final routeState = context.watch<RouteBloc>().state;
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenSize.width(100.0, context: context),
          right: ScreenSize.width(100.0, context: context),
          top: ScreenSize.height(30.0, context: context),
          bottom: ScreenSize.height(30.0, context: context)),
      child: BlocBuilder<RouteBloc, RouteState>(
        builder: (context, state) {
          //Resize menu text depending on which is selected
          double font1 = 0;
          double font2 = 0;
          if (routeState.page.toString() == "HomePage") {
            font1 = 10;
            font2 = 0;
          } else if (routeState.page.toString() == "AboutPage") {
            font1 = 0;
            font2 = 10;
          }

          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    context
                        .read<RouteBloc>()
                        .add(const PageChanged(pageIndex: 0));
           
                      Navigator.of(context).pop();
                  
                  },
                  child: Text("The Mαth∫etΣs",
                      style: AppTextStyles.bangersRegular(
                          context, themeState.theme.foregoundColor,
                          active: font1)),
                ),
                GestureDetector(
                  onTap: () {
                    context
                        .read<RouteBloc>()
                        .add(const PageChanged(pageIndex: 1));
                    Navigator.pushNamed(context, "/about");
                  },
                  child: Text("About",
                      style: AppTextStyles.maliBold(
                          context, themeState.theme.foregoundColor,
                          active: font2)),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
