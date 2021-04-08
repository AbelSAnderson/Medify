import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/models/user.dart';
import 'package:medify/repositories/user_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.userRepository) : super(ProfileLoading()) {
    var currentUser = userRepository.currentUser;
    emit(ProfileLoaded(currentUser));
  }

  final UserRepository userRepository;

  editProfileDetails(User user) async {
    emit(ProfileLoading());
    try {
      var updatedUser = await userRepository.updateUserToApi(user);
      print(updatedUser.toJson());
      userRepository.updateUser(updatedUser);
      emit(ProfileLoaded(updatedUser));
    } catch (e) {
      emit(ProfileError());
    }
  }
}
