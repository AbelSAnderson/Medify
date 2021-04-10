import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/models/user.dart';
import 'package:medify/repositories/user_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.userRepository) : super(ProfileInitial()) {
    userRepository.streamController.stream.listen((event) {
      emit(ProfileLoading());
      var newUser = event;
      emit(ProfileLoaded(newUser));
    });
  }

  final UserRepository userRepository;
}
