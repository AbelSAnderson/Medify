import 'package:flutter/material.dart';
import 'package:medify/widgets/medication_form.dart';

class AddMedication extends StatefulWidget {
  @override
  _AddMedicationState createState() => _AddMedicationState();
}

class _AddMedicationState extends State<AddMedication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Medication"),
      ),
      body: MedicationForm(),
    );
  }
}
