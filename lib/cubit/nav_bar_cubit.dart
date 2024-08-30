import 'package:bloc/bloc.dart';
import 'package:medify/repositories/user_repository.dart';
import 'package:meta/meta.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit(this.userRepository) : super(NavBarState.initial()) {
    var user = userRepository.currentUser;
    emit(state.copyWith(showClients: user.isCaregiver));
  }

  final UserRepository userRepository;

  void updateIndex(int index) {
    switch (index) {
      case 0:
        emit(state.copyWith(title: "Home", index: index));
        break;
      case 1:
        emit(state.copyWith(title: "Search", index: index));
        break;
      case 2:
        emit(state.copyWith(title: "Profile", index: index));
        break;
      case 3:
        emit(state.copyWith(title: "Clients", index: index));
        break;
      default:
        emit(NavBarState.initial());
    }
  }

  showClientsScreen(bool value) async {
    try {
      var previousUser = userRepository.currentUser;
      previousUser.isCaregiver = value;
      await userRepository.updateUserToApi(previousUser);
      emit(state.copyWith(showClients: value));
    } catch (e) {
      emit(state.copyWith(isError: true));
    }
  }
}

@immutable
class NavBarState {
  final String title;
  final int index;
  final bool showClients;
  final bool isError;

  const NavBarState({required this.title, required this.index, required this.showClients, required this.isError});

  NavBarState.initial()
      : this(
    title: "Home",
    index: 0,
    showClients: false,
    isError: false,
  );

  NavBarState copyWith({
    String? title,
    int? index,
    bool? showClients,
    bool? isError,
  }) {
    return NavBarState(
      title: title ?? this.title,
      index: index ?? this.index,
      showClients: showClients ?? this.showClients,
      isError: isError ?? false,
    );
  }
}

