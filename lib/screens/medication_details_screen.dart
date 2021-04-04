import 'package:flutter/material.dart';
import 'package:medify/database/models/medication.dart';
import 'package:medify/database/models/medication_info.dart';
import 'package:medify/widgets/medication_details.dart';
import 'package:medify/widgets/occurance_details.dart';

class MedicationDetailsScreen extends StatelessWidget {
  final Medication _medication;

  MedicationDetailsScreen(this._medication);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_medication.brandName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // OccuranceDetails(_medication),
            MedicationDetails(_medication),
          ],
        ),
      ),
    );
  }
}
