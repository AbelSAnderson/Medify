import 'package:flutter/material.dart';
import 'package:medify/database1/models/medication_info.dart';
import 'package:medify/widgets/medication_details.dart';
import 'package:medify/widgets/occurance_details.dart';

class MedicationOccurrenceDetailsScreen extends StatelessWidget {
  final MedicationInfo _medication;

  MedicationOccurrenceDetailsScreen(this._medication);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO-FIX
        title: Text(_medication.medication!.brandName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            OccurrenceDetails(_medication),
            // TODO-FIX
            MedicationDetails(_medication.medication!),
          ],
        ),
      ),
    );
  }
}
