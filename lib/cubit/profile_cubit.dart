import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/models/user.dart';
import 'package:medify/repositories/user_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.userRepository) : super(ProfileInitial()) {
    _streamSubscription = userRepository.streamController.stream.listen((user) {
      emit(ProfileLoading());
      var newUser = user;
      emit(ProfileLoaded(newUser));
    });
  }

  StreamSubscription _streamSubscription;
  final UserRepository userRepository;

  loadProfile(User user) async {
    emit(ProfileLoading());
    await Future.delayed(Duration.zero);
    var newUser = user;
    emit(ProfileLoaded(newUser));
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
