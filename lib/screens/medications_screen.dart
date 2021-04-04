import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/constants.dart';
import 'package:medify/cubit/medications_cubit.dart';
import 'package:medify/database/models/medication_event.dart';
import 'package:medify/database/models/medication_info.dart';
import 'package:medify/screens/medication_details_screen.dart';
import 'package:medify/scale.dart';

class MedicationsScreen extends StatelessWidget {
  final List<MedicationInfo> medications;

  MedicationsScreen(this.medications);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medications"),
      ),
      body: _medicationsList(medications),
    );
  }

  Widget _medicationsList(List<MedicationInfo> medications) {
    return ListView.builder(
      itemCount: medications.length,
      itemBuilder: (context, index) {
        var med = medications[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.sv, horizontal: 16.sh),
          child: Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 12.sv, horizontal: 12.sh),
              title: Text(
                med.medication.brandName,
                style: TextStyle(fontSize: 20.sf),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 24.sf,
              ),
              leading: Image(
                image: getMedTypeImage(med.medicationType, false),
                width: 35.sh,
                height: 35.sv,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MedicationDetailsScreen(med.medication)));
              },
            ),
          ),
        );
      },
    );
  }
}
