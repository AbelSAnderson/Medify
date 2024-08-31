import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:medify/constants.dart';
import 'package:medify/cubit/medications_cubit.dart';
import 'package:medify/database1/models/medication_info.dart';
import 'package:medify/repositories/user_repository.dart';
import 'package:medify/scale.dart';
import 'package:medify/widgets/confirmation_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class OccurrenceDetails extends StatelessWidget {
  final MedicationInfo medication;

  OccurrenceDetails(this.medication);

  _launchCaller(BuildContext context, String phoneNum) async {
    var url = "tel:$phoneNum";
    // TODO-FIX
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          scrollable: true,
          insetPadding:
              EdgeInsets.symmetric(horizontal: 20.sh, vertical: 20.sv),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.sh, vertical: 12.5.sv),
          titlePadding: EdgeInsets.only(left: 20.sh, right: 20.sh, top: 20.sv),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          title: Text("No Phone App"),
          content: Container(
            width: 300.sh,
            child: Column(
              children: [
                Text(
                    "Unable to redirect. Your device does not have a phone app."),
                Align(
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
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sh),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "Occurance Details",
                style: TextStyle(fontSize: 28.sf),
                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.symmetric(vertical: 8.sv),
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 2)),
              ),
            ),
            (medication.pillsRemaining != null &&
                    medication.pillsRemaining != -1)
                ? Column(
                    children: [
                      SizedBox(height: 20.sv),
                      Text(
                        "Pills Left: ${medication.pillsRemaining}",
                        style: TextStyle(fontSize: 16.sf),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(height: 20.sv),
            Text(
              "Repeats: ${getRepeatsString(medication.repeat)}",
              style: TextStyle(fontSize: 16.sf),
            ),
            SizedBox(height: 20.sv),
            Text(
              "Start Date: ${formatDate(medication.takeAt, [
                    MM,
                    ' ',
                    dd,
                    ', ',
                    yyyy
                  ])}",
              style: TextStyle(fontSize: 16.sf),
            ),
            SizedBox(height: 20.sv),
            Text(
              "Time: ${formatDate(medication.takeAt, [h, ":", nn, " ", am])}",
              style: TextStyle(fontSize: 16.sf),
            ),
            SizedBox(height: 20.sv),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 2,
                  child: PlatformElevatedButton(
                    child: Text(
                      "Contact Pharmacy",
                      style: TextStyle(fontSize: 14.sf, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      //Show phone dialler
                      _launchCaller(
                          context,
                          RepositoryProvider.of<UserRepository>(context)
                              .currentUser
                              .pharmacyNumber);
                    },
                    cupertino: (context, platform) =>
                        CupertinoElevatedButtonData(
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
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: PlatformElevatedButton(
                    child: Text(
                      "Remove Medication",
                      style: TextStyle(fontSize: 14.sf, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (newContext) => BlocProvider.value(
                          value: BlocProvider.of<MedicationsCubit>(context),
                          child: ConfirmationDialog(
                            confirmClicked: () =>
                                BlocProvider.of<MedicationsCubit>(context)
                                    .deleteMedication(medication),
                            title: "Remove Medication",
                            message:
                                "Are you sure you want to remove this medication?",
                            buttonTitle: "Remove",
                            popScreen: true,
                          ),
                        ),
                      );
                    },
                    cupertino: (context, platform) =>
                        CupertinoElevatedButtonData(
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
