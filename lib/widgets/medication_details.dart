import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:medify/database/models/medication.dart';
import 'package:medify/scale.dart';

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
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sh, vertical: 4.sv),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "Medication Information",
                style: TextStyle(fontSize: 28.sf),
                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.symmetric(vertical: 8.sv),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: 2)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sh, vertical: 8.sv),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Purpose",
                      style: TextStyle(fontSize: 22.sf),
                    ),
                    PlatformIconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        _showPurpose ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        size: 30.sf,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPurpose == false ? _showPurpose = true : _showPurpose = false;
                        });
                      },
                    ),
                  ],
                ),
                _showPurpose
                    ? Text(
                        medication.usage,
                        style: TextStyle(fontSize: 14.sf),
                        textAlign: TextAlign.start,
                      )
                    : Container(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sh, vertical: 8.sv),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Warnings",
                      style: TextStyle(fontSize: 22.sf),
                    ),
                    PlatformIconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        _showWarnings ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        size: 30.sf,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _showWarnings == false ? _showWarnings = true : _showWarnings = false;
                        });
                      },
                    ),
                  ],
                ),
                _showWarnings
                    ? Text(
                        medication.precaution,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14.sf),
                      )
                    : Container(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sh, vertical: 8.sv),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dosage & Administration",
                      style: TextStyle(fontSize: 22.sf),
                    ),
                    PlatformIconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        _showDosage ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        size: 30.sf,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _showDosage == false ? _showDosage = true : _showDosage = false;
                        });
                      },
                    ),
                  ],
                ),
                _showDosage
                    ? Text(
                        medication.dosage,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14.sf),
                      )
                    : Container(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sh, vertical: 8.sv),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Active Ingredients",
                      style: TextStyle(fontSize: 22.sf),
                    ),
                    PlatformIconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        _showIngredients ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        size: 30.sf,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _showIngredients == false ? _showIngredients = true : _showIngredients = false;
                        });
                      },
                    ),
                  ],
                ),
                _showIngredients
                    ? Text(
                        medication.ingredient,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14.sf),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
