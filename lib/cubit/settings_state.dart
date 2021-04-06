part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final double fontScaleFactor;

  const SettingsState({
    @required this.fontScaleFactor,
  });

  SettingsState.initial()
      : this(
          fontScaleFactor: 1.5,
        );

  SettingsState copyWith({
    double fontScaleFactor,
  }) {
    return SettingsState(
      fontScaleFactor: fontScaleFactor ?? this.fontScaleFactor,
    );
  }

  @override
  List<Object> get props => [
        fontScaleFactor,
      ];
}
