import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:medify/database1/models/medication.dart';
import 'package:medify/database1/openFDA_queries.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchArrived());

  searchFor(String searchTerm) async {
    emit(SearchSearching());
    try {
      emit(SearchComplete(await OpenFDAQueries().retrieveMedicationsWhereName(searchTerm)));
    } catch (e) {
      emit(SearchError(e));
    }
  }
}
