part of 'nav_bar_cubit.dart';

@immutable
class NavBarState {
  final String title;
  final int index;
  final bool showClients;
  final bool isError;

  const NavBarState({this.title, this.index, this.showClients, this.isError});

  NavBarState.initial()
      : this(
          title: "Home",
          index: 0,
          showClients: false,
          isError: false,
        );

  NavBarState copyWith({
    String title,
    int index,
    bool showClients,
    bool isError,
  }) {
    return NavBarState(
      title: title ?? this.title,
      index: index ?? this.index,
      showClients: showClients ?? this.showClients,
      isError: isError ?? false,
    );
  }
}
