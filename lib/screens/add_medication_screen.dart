import 'package:flutter/material.dart';
import 'package:medify/database/models/medication.dart';
import 'package:medify/widgets/medication_form.dart';

class AddMedicationScreen extends StatelessWidget {
  final Medication medication;

  AddMedicationScreen(this.medication);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Medication"),
      ),
      body: MedicationForm(medication),
    );
  }
}
