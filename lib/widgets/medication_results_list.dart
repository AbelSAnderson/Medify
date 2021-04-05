import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:medify/screens/add_medication_screen.dart';
import 'package:medify/screens/medication_details_screen.dart';
import 'package:medify/scale.dart';

class MedicationResultsList extends StatelessWidget {
  final medications;

  MedicationResultsList(this.medications, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: medications.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black26)),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 10.sv, horizontal: 10.sh),
              title: Text(
                medications[index].brandName,
                style: TextStyle(fontSize: 16.sf),
              ),
              trailing: PlatformIconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(
                  Icons.add,
                  size: 24.sf,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddMedicationScreen(medications[index])));
                },
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MedicationDetailsScreen(medications[index])));
              },
            ),
          );
        },
      ),
    );
  }
}
