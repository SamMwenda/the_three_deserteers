import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:the_three_deserteers/App/Screens/Homepage/homepage.dart';

part 'route_event.dart';
part 'route_state.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  RouteBloc({required List<Widget> pages})
      : super(RouteState(pages: pages)) {
    on<PageChanged>(_onpageChanged);
  }
  void _onpageChanged(
    PageChanged event,
    Emitter<RouteState> emit,
  ) {
    emit(state.copyWith(page: state.pages[event.pageIndex]));
  }
}
