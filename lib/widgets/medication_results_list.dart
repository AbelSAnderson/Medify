import 'package:flutter/material.dart';
import 'package:medify/screens/add_medication_screen.dart';
import 'package:medify/screens/medication_details_screen.dart';

class MedicationResultsList extends StatelessWidget {
  final medications;

  MedicationResultsList(this.medications, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: medications.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black26)),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              title: Text(medications[index].brandName),
              trailing: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddMedicationScreen(medications[index])));
                },
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MedicationDetailsScreen(medications[index])));
              },
            ),
          );
        },
      ),
    );
  }
}
