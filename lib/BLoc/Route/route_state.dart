part of 'route_bloc.dart';

class RouteState extends Equatable {
  const RouteState({
    required this.pages,
    this.page = const HomePage(),
  });

  /// The list of all available [page]s.
  final List<Widget> pages;

  /// Currently selected [page].
  final Widget page;

  @override
  List<Object> get props => [pages, page];

  RouteState copyWith({
    List<Widget>? pages,
    Widget? page,
  }) {
    return RouteState(
      pages: pages ?? this.pages,
      page: page ?? this.page,
    );
  }
}
