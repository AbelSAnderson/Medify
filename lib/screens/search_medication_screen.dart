import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/cubit/search_cubit.dart';
import 'package:medify/widgets/medication_results_list.dart';
import 'package:medify/widgets/search_bar.dart';

class SearchMedicationScreen extends StatefulWidget {
  @override
  _SearchMedicationScreenState createState() => _SearchMedicationScreenState();
}

class _SearchMedicationScreenState extends State<SearchMedicationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
        Widget item = Text("");

        if (state is SearchArrived) {
          item = Center(child: Text(""));
        } else if (state is SearchSearching) {
          item = Center(child: CircularProgressIndicator());
        } else if (state is SearchComplete) {
          item = MedicationResultsList(state.medications);
        } else if (state is SearchError) {
          item = Center(
            child: Text(state.errorMessage),
          );
        }
        return Column(children: [SearchBar((inputText) => BlocProvider.of<SearchCubit>(context).searchFor(inputText)), item]);
      }),
    );
  }
}
