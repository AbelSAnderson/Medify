import 'package:flutter/material.dart';
import 'package:medify/Blocs/search_bloc.dart';
import 'package:medify/screens/add_medication_screen.dart';
import 'package:medify/screens/medication_details_screen.dart';

class MedicationResultsList extends StatelessWidget {
  final SearchCubit _searchCubit;

  MedicationResultsList(this._searchCubit, {Key key}) : super(key: key);
  
  // [
  //   Medication("0", "brandName", "usage", "precaution", "dosage", "ingredient"),
  //   Medication("1", "brandName2", "usage2", "precaution2", "dosage2", "ingredient2"),
  //   Medication("2", "brandName3", "usage3", "precaution3", "dosage3", "ingredient3"),
  //   Medication("3", "brandName4", "usage4", "precaution4", "dosage4", "ingredient4"),
  //   Medication("4", "brandName5", "usage5", "precaution5", "dosage5", "ingredient5"),
  //   Medication("5", "brandName6", "usage6", "precaution6", "dosage6", "ingredient6"),
  // ];



  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: ListView.builder(
        itemCount: _searchCubit.state.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black26)),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              title: Text(_searchCubit.state[index].brandName),
              trailing: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddMedication()));
                },
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MedicationDetailsScreen(_searchCubit.state[index])));
              },
            ),
          );
        },
      ),
    );
  }
}
