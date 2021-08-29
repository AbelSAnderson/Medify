import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database1/models/user.dart';
import 'package:medify/repositories/user_repository.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this.userRepository) : super(EditProfileInitial());

  final UserRepository userRepository;

  editProfileDetails(User user) async {
    emit(EditProfileLoading());
    try {
      var updatedUser = await userRepository.updateUserToApi(user);
      userRepository.updateUser(updatedUser);
      emit(EditProfileSucceeded());
    } catch (e) {
      emit(EditProfileFailed("Email already used."));
    }
  }
}
