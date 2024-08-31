import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medify/database/model_queries/medication_event_queries.dart';
import 'package:medify/database/models/medication_event.dart';

class ClientDetailsCubit extends Cubit<ClientDetailsState> {
  List<MedicationEvent>? allMedications;
  final MedicationEventQueries medicationEventQueries;

  ClientDetailsCubit(this.medicationEventQueries)
      : super(ClientDetailsInitial());

  loadClientMedications(int userId) async {
    await Future<void>.delayed(Duration(milliseconds: 100));
    emit(ClientDetailsLoading());
    allMedications =
        await medicationEventQueries.retrieveAllFromApiForUser(userId);
    emit(ClientDetailsLoaded(_sortMedications(allMedications!)));
  }

  filterMedications(String value) {
    emit(ClientDetailsLoading());

    var filteredMeds = allMedications?.where((element) {
      var todayDateTime = DateTime.now();
      var todayDate = DateTime(
        todayDateTime.year,
        todayDateTime.month,
        todayDateTime.day,
      );
      var medDate = DateTime(
        element.datetime.year,
        element.datetime.month,
        element.datetime.day,
      );

      var filterDays = _getFilterDaysAmount(value);
      return medDate.isAfter(todayDate.subtract(Duration(days: filterDays))) ||
          medDate.isAtSameMomentAs(todayDate.subtract(
            Duration(days: filterDays),
          ));
    });

    emit(ClientDetailsLoaded(filteredMeds?.toList() ?? []));
  }

  int _getFilterDaysAmount(String value) {
    switch (value) {
      case "Today":
        return 0;
      case "1 week":
        return 7;
      case "2 week":
        return 14;
      case "1 month":
        return 30;
      default:
        return 0;
    }
  }

  _sortMedications(List<MedicationEvent> medicationEvents) {
    return medicationEvents
      ..sort((a, b) {
        if (a.medTaken) {
          return 1;
        } else {
          return 0;
        }
      });
  }

  int _getMedTakenValue(String value) {
    switch (value) {
      case "Not Taken":
        return 1;
      case "Taken":
        return 1;
      default:
        return 0;
    }
  }
}

abstract class ClientDetailsState extends Equatable {
  const ClientDetailsState();

  @override
  List<Object> get props => [];
}

class ClientDetailsInitial extends ClientDetailsState {
  @override
  List<Object> get props => [];
}

class ClientDetailsLoading extends ClientDetailsState {
  @override
  List<Object> get props => [];
}

class ClientDetailsLoaded extends ClientDetailsState {
  final List<MedicationEvent> medications;

  const ClientDetailsLoaded([this.medications = const []]);

  @override
  List<Object> get props => [medications];
}

class ClientDetailsError extends ClientDetailsState {
  @override
  List<Object> get props => [];
}
