part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState({
    required this.themes,
    this.theme = const WaffleSamTheme(),
  });

  /// The list of all available [Theme]s.
  final List<AppTheme> themes;

  /// Currently selected [Theme].
  final AppTheme theme;

  @override
  List<Object> get props => [themes, theme];

  ThemeState copyWith({
    List<AppTheme>? themes,
    AppTheme? theme,
  }) {
    return ThemeState(
      themes: themes ?? this.themes,
      theme: theme ?? this.theme,
    );
  }
}
