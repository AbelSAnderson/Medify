import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/constants.dart';
import 'package:medify/cubit/medications_cubit.dart';
import 'package:medify/database/models/medication_info.dart';
import 'package:medify/scale.dart';

class OccuranceDetails extends StatelessWidget {
  final MedicationInfo medication;

  OccuranceDetails(this.medication);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sh),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "Occurance Details",
                style: TextStyle(fontSize: 28.sf),
                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.symmetric(vertical: 8.sv),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: 2)),
              ),
            ),
            medication.pillsRemaining != null
                ? Column(
                    children: [
                      SizedBox(height: 20.sv),
                      Text(
                        "Pills Left: ${medication.pillsRemaining}",
                        style: TextStyle(fontSize: 16.sf),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(height: 20.sv),
            Text(
              "Repeats: ${getRepeatsString(medication.repeat)}",
              style: TextStyle(fontSize: 16.sf),
            ),
            SizedBox(height: 20.sv),
            Text(
              "Start Date: ${formatDate(medication.takeAt, [MM, ' ', dd, ', ', yyyy])}",
              style: TextStyle(fontSize: 16.sf),
            ),
            SizedBox(height: 20.sv),
            Text(
              "Start Date: ${formatDate(medication.takeAt, [h, ":", nn, " ", am])}",
              style: TextStyle(fontSize: 16.sf),
            ),
            SizedBox(height: 20.sv),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: Text(
                    "Contact Pharmacy",
                    style: TextStyle(fontSize: 14.sf),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    //Show phone dialler
                  },
                ),
                ElevatedButton(
                  child: Text(
                    "Remove Medication",
                    style: TextStyle(fontSize: 14.sf),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () {
                    //Call bloc to remove medication
                    BlocProvider.of<MedicationsCubit>(context).deleteMedication(medication);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
