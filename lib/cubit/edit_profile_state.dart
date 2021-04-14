part of 'edit_profile_cubit.dart';

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
