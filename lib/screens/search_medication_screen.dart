import 'package:flutter/material.dart';
import 'package:medify/widgets/medication_results_list.dart';
import 'package:medify/widgets/search_bar.dart';

class SearchMedicationScreen extends StatefulWidget {
  @override
  _SearchMedicationScreenState createState() => _SearchMedicationScreenState();
}

class _SearchMedicationScreenState extends State<SearchMedicationScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(),
        MedicationResultsList(),
      ],
    );
  }
}
