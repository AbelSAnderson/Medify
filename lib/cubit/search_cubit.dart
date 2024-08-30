import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:medify/database1/models/medication.dart';
import 'package:medify/database1/openFDA_queries.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchArrived());

  searchFor(String searchTerm) async {
    emit(SearchSearching());
    try {
      emit(SearchComplete(await OpenFDAQueries().retrieveMedicationsWhereName(searchTerm)));
    } on Exception catch (e) {
      emit(SearchError(e));
    }
  }
}

@immutable
abstract class SearchState {
  final List<Medication> medications;

  SearchState(this.medications);
}

class SearchArrived extends SearchState {
  SearchArrived() : super([]);
}

class SearchSearching extends SearchState {
  SearchSearching() : super([]);
}

class SearchComplete extends SearchState {
  SearchComplete(List<Medication> medications) : super(medications);
}

class SearchError extends SearchState {
  final Exception error;

  SearchError(this.error) : super([]);
}

