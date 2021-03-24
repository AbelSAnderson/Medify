import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/constants.dart';
import 'package:medify/cubit/medications_cubit.dart';
import 'package:medify/database/models/medication_event.dart';
import 'package:medify/screens/medication_details_screen.dart';

class MedicationsScreen extends StatelessWidget {
  final List<MedicationEvent> medications;

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

  Widget _medicationsList(List<MedicationEvent> medications) {
    return ListView.builder(
      itemCount: medications.length,
      itemBuilder: (context, index) {
        var med = medications[index];
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
            child: ListTile(
              contentPadding: EdgeInsets.all(12),
              title: Text(med.medicationInfo.medication.brandName),
              trailing: Icon(Icons.keyboard_arrow_right),
              leading: Image(
                image: getMedTypeImage(med.medicationInfo.medicationType, true),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedicationDetailsScreen(med.medicationInfo.medication),
                    ));
              },
            ),
          ),
        );
      },
    );
  }
}
