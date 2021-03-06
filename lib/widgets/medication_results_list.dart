import 'package:flutter/material.dart';
import 'package:medify/Database/Models/medication.dart';

class MedicationResultsList extends StatelessWidget {
  final _medicationList = [
    Medication(0, "brandName", "usage", "precaution", "dosage", "ingredient"),
    Medication(1, "brandName", "usage", "precaution", "dosage", "ingredient"),
    Medication(2, "brandName", "usage", "precaution", "dosage", "ingredient"),
    Medication(3, "brandName", "usage", "precaution", "dosage", "ingredient"),
    Medication(4, "brandName", "usage", "precaution", "dosage", "ingredient"),
    Medication(5, "brandName", "usage", "precaution", "dosage", "ingredient"),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _medicationList.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black26)),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              title: Text(_medicationList[index].brandName),
              trailing: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {},
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
