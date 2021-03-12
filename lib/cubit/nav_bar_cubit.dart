import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(ShowHome());

  void updateIndex(int index) {
    switch (index) {
      case 0:
        emit(ShowHome());
        break;
      case 1:
        emit(ShowSearch());
        break;
      case 2:
        emit(ShowProfile());
        break;
      case 3:
        emit(ShowClients());
        break;
      default:
        emit(ShowHome());
    }
  }
}
