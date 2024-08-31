import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/model_queries/caregivers_queries.dart';
import 'package:medify/database/models/user.dart';

class CaregiversCubit extends Cubit<CaregiversState> {
  CaregiversCubit(this.caregiversQueries) : super(CaregiversInitial());

  final CaregiversQueries caregiversQueries;

  loadCaregivers() async {
    await Future<void>.delayed(Duration(milliseconds: 1));
    emit(CaregiversLoading());
    try {
      var caregivers = await caregiversQueries.retrieveAllFromApi();
      emit(CaregiversLoaded(caregivers));
    } catch (e) {}
  }

  removeCaregiver(User caregiver) async {
    if (state is CaregiversLoaded) {
      var previousState = state as CaregiversLoaded;
      emit(CaregiversLoading());
      await Future.delayed(Duration(milliseconds: 300));
      try {
        var jsonResponse = await caregiversQueries.deleteFromApi(caregiver.id);
        if (jsonResponse["status"] != null) {
          if (jsonResponse["status"] == true) {
            var newCaregiversList = previousState.caregivers..removeWhere((element) => element.id == caregiver.id);
            emit(CaregiversLoaded(newCaregiversList));
          } else {
            emit(CaregiversError());
          }
        } else {
          emit(CaregiversError());
        }
      } catch (e) {
        emit(CaregiversError());
      }
    }
  }
}

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

