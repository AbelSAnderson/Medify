import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:medify/scale.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonTitle;
  final Function confirmClicked;
  final bool popScreen;

  ConfirmationDialog({
    required this.confirmClicked,
    required this.title,
    required this.message,
    required this.buttonTitle,
    this.popScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.sh, vertical: 20.sv),
      contentPadding: EdgeInsets.symmetric(horizontal: 10.sh, vertical: 10.sv),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.sv),
        child: Text(
          title,
          style: TextStyle(fontSize: 22.sf),
          textAlign: TextAlign.center,
        ),
      ),
      content: Container(
        width: 300.sh,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.sh),
          child: Column(
            children: [
              Text(
                message,
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
      child: PlatformElevatedButton(
        child: Text(
          buttonTitle,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.sf, color: Colors.white),
        ),
        onPressed: () {
          confirmClicked();
          Navigator.of(context, rootNavigator: true).pop('dialog');
          if (popScreen) {
            Navigator.of(context).pop();
          }
        },
        cupertino: (context, platform) => CupertinoElevatedButtonData(
          padding: EdgeInsets.symmetric(horizontal: 10),
        ),
        material: (context, platform) => MaterialElevatedButtonData(
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
          ),
        ),
        color: Colors.red,
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
