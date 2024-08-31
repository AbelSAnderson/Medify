import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/constants.dart';
import 'package:medify/cubit/medications_cubit.dart';
import 'package:medify/database/models/medication_info.dart';
import 'package:medify/scale.dart';
import 'package:medify/screens/medication_occurence_details_screen.dart';

class MedicationsScreen extends StatelessWidget {
  final List<MedicationInfo> medications;

  MedicationsScreen(this.medications);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medications"),
      ),
      body: BlocBuilder<MedicationsCubit, MedicationsState>(builder: (context, state) {
        if (state is MedicationsLoading) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        if (state is MedicationsLoaded) {
          return _medicationsList(medications);
        }
        return Container();
      }),
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
                // TODO-FIX
                med.medication!.brandName,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (newContext) => BlocProvider.value(
                      value: BlocProvider.of<MedicationsCubit>(context),
                      child: MedicationOccurrenceDetailsScreen(med),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
