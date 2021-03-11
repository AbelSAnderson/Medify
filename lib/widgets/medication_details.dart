import 'package:flutter/material.dart';
import 'package:medify/Database/Models/medication.dart';

class MedicationDetails extends StatefulWidget {
  final Medication medication;

  MedicationDetails(this.medication);

  @override
  _MedicationDetailsState createState() => _MedicationDetailsState();
}

class _MedicationDetailsState extends State<MedicationDetails> {
  bool _showPurpose = false;
  bool _showWarnings = false;
  bool _showDosage = false;
  bool _showIngredients = false;
  Medication medication;

  @override
  void initState() {
    super.initState();
    medication = widget.medication;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Text(
                "Medication Information",
                style: TextStyle(fontSize: 28),
              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 22),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: 2)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Purpose",
                        style: TextStyle(fontSize: 22),
                      ),
                      IconButton(
                        icon: Icon(
                          _showPurpose ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            _showPurpose == false ? _showPurpose = true : _showPurpose = false;
                          });
                        },
                      ),
                    ],
                  ),
                  _showPurpose ? Text(medication.usage, textAlign: TextAlign.start) : Container(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Warnings",
                        style: TextStyle(fontSize: 22),
                      ),
                      IconButton(
                        icon: Icon(
                          _showWarnings ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            _showWarnings == false ? _showWarnings = true : _showWarnings = false;
                          });
                        },
                      ),
                    ],
                  ),
                  _showWarnings ? Text(medication.precaution, textAlign: TextAlign.start) : Container(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dosage & Administration",
                        style: TextStyle(fontSize: 22),
                      ),
                      IconButton(
                        icon: Icon(
                          _showDosage ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            _showDosage == false ? _showDosage = true : _showDosage = false;
                          });
                        },
                      ),
                    ],
                  ),
                  _showDosage ? Text(medication.dosage, textAlign: TextAlign.start) : Container(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Active Ingredients",
                        style: TextStyle(fontSize: 22),
                      ),
                      IconButton(
                        icon: Icon(
                          _showIngredients ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            _showIngredients == false ? _showIngredients = true : _showIngredients = false;
                          });
                        },
                      ),
                    ],
                  ),
                  _showIngredients ? Text(medication.ingredient, textAlign: TextAlign.start) : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
