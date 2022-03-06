import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:the_three_deserteers/Theme/theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required List<AppTheme> themes})
      : super(ThemeState(themes: themes)) {
    on<ThemeChanged>(_onThemeChanged);
  }
  void _onThemeChanged(
    ThemeChanged event,
    Emitter<ThemeState> emit,
  ) {
    emit(state.copyWith(theme: state.themes[event.themeIndex]));
  }
}
