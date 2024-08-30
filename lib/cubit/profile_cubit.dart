import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database1/models/user.dart';
import 'package:medify/repositories/user_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository userRepository;
  late StreamSubscription _streamSubscription;

  ProfileCubit(this.userRepository) : super(ProfileInitial()) {
    _streamSubscription = userRepository.streamController.stream.listen((user) {
      emit(ProfileLoading());
      var newUser = user;
      emit(ProfileLoaded(newUser));
    });
  }

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

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoaded extends ProfileState {
  final User user;

  ProfileLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class ProfileError extends ProfileState {
  @override
  List<Object> get props => [];
}
