import 'package:bloc/bloc.dart';
import 'package:medify/database/models/medication.dart';
import 'package:medify/database/openFDA_queries.dart';

class SearchCubit extends Cubit<List<Medication>> {
  SearchCubit() : super([]);

  searchFor(String searchTerm) async {
    emit(await OpenFDAQueries().retrieveMedicationsWhereName(searchTerm));
  }
}