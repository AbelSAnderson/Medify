part of 'caregivers_cubit.dart';

abstract class CaregiversState extends Equatable {
  const CaregiversState();

  @override
  List<Object> get props => [];
}

class CaregiversInitial extends CaregiversState {
  @override
  List<Object> get props => [];
}

class CaregiversLoading extends CaregiversState {
  @override
  List<Object> get props => [];
}

class CaregiversLoaded extends CaregiversState {
  final List<User> caregivers;

  const CaregiversLoaded([this.caregivers = const []]);

  @override
  List<Object> get props => [caregivers];
}

class CaregiversError extends CaregiversState {
  @override
  List<Object> get props => [];
}
