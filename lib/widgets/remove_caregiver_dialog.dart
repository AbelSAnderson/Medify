import 'package:flutter/material.dart';
import 'package:medify/scale.dart';

class RemoveCaregiverDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.sh, vertical: 20.sv),
      contentPadding: EdgeInsets.symmetric(horizontal: 10.sh, vertical: 10.sv),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.sv),
        child: Text(
          "Remove Caregiver",
          style: TextStyle(fontSize: 22.sf, color: Colors.blue),
          textAlign: TextAlign.center,
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.sh),
          child: Column(
            children: [
              Text(
                "Are you sure you want to \n remove this caregiver?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sf),
              ),
              SizedBox(height: 20.sv),
              _removeButton(context),
              _cancelButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _removeButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text(
          "Remove",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.sf),
        ),
        onPressed: () {
          //Replace this with remove caregiver logic
          Navigator.of(context, rootNavigator: true).pop('dialog');
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
          padding: EdgeInsets.symmetric(horizontal: 16.sh),
        ),
      ),
    );
  }

  Widget _cancelButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: Text(
          "Cancel",
          style: TextStyle(fontSize: 14.sf),
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
        },
      ),
    );
  }
}
