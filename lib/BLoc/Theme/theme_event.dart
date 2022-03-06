part of 'theme_bloc.dart';


abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  const ThemeChanged({required this.themeIndex});

  /// The index of the changed theme in [ThemeState.themes].
  final int themeIndex;

  @override
  List<Object> get props => [themeIndex];
}
