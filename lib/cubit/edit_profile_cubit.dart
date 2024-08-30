import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database1/models/user.dart';
import 'package:medify/repositories/user_repository.dart';

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

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {
  @override
  List<Object> get props => [];
}

class EditProfileLoading extends EditProfileState {
  @override
  List<Object> get props => [];
}

class EditProfileSucceeded extends EditProfileState {
  @override
  List<Object> get props => [];
}

class EditProfileFailed extends EditProfileState {
  final String errorMsg;

  EditProfileFailed(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
