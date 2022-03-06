part of 'route_bloc.dart';


abstract class RouteEvent extends Equatable {
  const RouteEvent();
}

class PageChanged extends RouteEvent {
  const PageChanged({required this.pageIndex});

  final int pageIndex;

  @override
  List<Object> get props => [pageIndex];
}
