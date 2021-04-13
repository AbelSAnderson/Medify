import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/app_exceptions.dart';
import 'package:medify/cubit/search_cubit.dart';
import 'package:medify/widgets/medication_results_list.dart';
import 'package:medify/widgets/search_bar.dart';
import 'package:medify/scale.dart';

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
          item = Center(child: CircularProgressIndicator.adaptive());
        } else if (state is SearchComplete) {
          item = MedicationResultsList(state.medications);
        } else if (state is SearchError) {
          var errorText = "No Results Found.";
          if (state.error is BadRequestException) {
            errorText = "An Error Has Occured. Please Try Again.";
          }
          item = Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.sh, vertical: 12.sv),
            child: Center(
              child: Text(
                errorText,
                style: TextStyle(fontSize: 18.sf),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        return Column(
          children: [
            SearchBar(
              onSearch: (inputText) => BlocProvider.of<SearchCubit>(context).searchFor(inputText),
              hintText: "Search for a medication",
            ),
            item
          ],
        );
      }),
    );
  }
}
