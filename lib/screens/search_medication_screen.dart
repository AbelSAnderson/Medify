import 'package:flutter/material.dart';
import 'package:medify/Blocs/search_bloc.dart';
import 'package:medify/widgets/medication_results_list.dart';
import 'package:medify/widgets/search_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchMedicationScreen extends StatefulWidget {
  @override
  _SearchMedicationScreenState createState() => _SearchMedicationScreenState();
}

class _SearchMedicationScreenState extends State<SearchMedicationScreen> {

  var searchCubit = SearchCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (state) => SearchCubit(),
        child: Column(
          children: [
            SearchBar(onSearch: (String searchText) => searchCubit.searchFor(searchText)),
            MedicationResultsList(searchCubit),
          ],
        ));
  }
}
