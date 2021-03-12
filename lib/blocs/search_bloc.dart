import 'package:bloc/bloc.dart';
import 'package:medify/Database/Models/medication.dart';
import 'package:medify/Database/openFDA_queries.dart';

class SearchCubit extends Cubit<List<Medication>> {
  SearchCubit() : super([]);

  searchFor(String searchTerm) async {
    emit(await OpenFDAQueries().retrieveMedicationsWhereName(searchTerm));
  }
}