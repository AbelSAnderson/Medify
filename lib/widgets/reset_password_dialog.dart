import 'package:flutter/material.dart';
import 'package:medify/scale.dart';

class ResetPasswordDialog extends StatelessWidget {
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
          "Forgot your password?",
          style: TextStyle(fontSize: 22.sf),
          textAlign: TextAlign.center,
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.sh),
          child: Column(
            children: [
              _emailField(),
              SizedBox(height: 20.sv),
              _submitButton(context),
              _cancelButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Email",
            style: TextStyle(fontSize: 14.sf),
          ),
        ),
        SizedBox(height: 10.sv),
        TextFormField(
          style: TextStyle(fontSize: 16.sf),
          initialValue: "",
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 32),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 14.sv, horizontal: 14),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text(
          "Reset Password",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.sf),
        ),
        onPressed: () {
          //Replace this with password resetting logic
          Navigator.of(context, rootNavigator: true).pop('dialog');
        },
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
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
