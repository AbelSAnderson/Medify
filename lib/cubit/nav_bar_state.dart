part of 'nav_bar_cubit.dart';

@immutable
abstract class NavBarState {
  final String title = "";
  final int index = 0;
}

class ShowHome extends NavBarState {
  final String title = "Home";
  final int index = 0;
}

class ShowSearch extends NavBarState {
  final String title = "Search";
  final int index = 1;
}

class ShowProfile extends NavBarState {
  final String title = "Profile";
  final int index = 2;
}

class ShowClients extends NavBarState {
  final String title = "Clients";
  final int index = 3;
}
