import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/models/user.dart';
import 'package:medify/dummy_data.dart' as DummyData;

part 'caregivers_state.dart';

class CaregiversCubit extends Cubit<CaregiversState> {
  CaregiversCubit() : super(CaregiversInitial());

  loadCaregivers() async {
    await Future<void>.delayed(Duration(milliseconds: 1));
    emit(CaregiversLoading());
    var caregivers = DummyData.getConnectedUsers();
    emit(CaregiversLoaded(caregivers));
  }
}
