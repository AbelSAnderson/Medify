import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:medify/constants.dart';
import 'package:medify/cubit/client_details_cubit.dart';
import 'package:medify/cubit/clients_cubit.dart';
import 'package:medify/database/models/medication_event.dart';
import 'package:medify/database/models/user_connection.dart';
import 'package:medify/scale.dart';
import 'package:medify/widgets/confirmation_dialog.dart';

class ClientDetailsScreen extends StatelessWidget {
  final UserConnection userConnection;

  ClientDetailsScreen(this.userConnection);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userConnection.user.name),
        actions: [
          FilterMedicationsDropDown(),
          SizedBox(
            width: 14.sh,
          ),
          PlatformIconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (newContext) => BlocProvider.value(
                  value: BlocProvider.of<ClientsCubit>(context),
                  child: ConfirmationDialog(
                    confirmClicked: () => BlocProvider.of<ClientsCubit>(context).removeClient(userConnection),
                    title: "Remove Client",
                    message: "Are you sure you want to remove this client?",
                    buttonTitle: "Remove",
                    popScreen: true,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ClientDetailsCubit, ClientDetailsState>(
        builder: (context, state) {
          if (state is ClientDetailsInitial) {
            _loadMeds(context);
          }
          if (state is ClientDetailsLoading) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is ClientDetailsLoaded) {
            return ShowMedicationsList(state.medications);
          }
          if (state is ClientDetailsError) {
            return Center(
              child: Text(
                "Error",
                style: TextStyle(fontSize: 20.sf),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  _loadMeds(BuildContext context) async {
    await BlocProvider.of<ClientDetailsCubit>(context).loadClientMedications(userConnection.user.id);
    BlocProvider.of<ClientDetailsCubit>(context).filterMedications("Today");
  }
}

class ShowMedicationsList extends StatelessWidget {
  final List<MedicationEvent> medications;
  ShowMedicationsList(this.medications);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: medications.length,
      itemBuilder: (context, index) {
        var med = medications[index];
        return Container(
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
          child: ListTile(
            title: Text(
              med.medicationInfo.medication.brandName,
              style: TextStyle(fontSize: 18.sf),
            ),
            subtitle: Text(
              formatDate(med.datetime, ["MM", " ", "d", ", ", "yyyy", " at ", "h", ":", "mm", "am"]),
              style: TextStyle(fontSize: 14.sf),
            ),
            leading: Image(
              image: getMedTypeImage(med.medicationInfo.medicationType, false),
              width: 40.sf,
              height: 40.sf,
            ),
            trailing: med.medTaken
                ? Text(
                    "Taken",
                    style: TextStyle(fontSize: 14.sf),
                  )
                : Text(
                    "Not Taken",
                    style: TextStyle(fontSize: 14.sf),
                  ),
          ),
        );
      },
    );
  }
}

class FilterMedicationsDropDown extends StatefulWidget {
  @override
  _FilterMedicationsDropDownState createState() => _FilterMedicationsDropDownState();
}

class _FilterMedicationsDropDownState extends State<FilterMedicationsDropDown> {
  String dropDownValue = "Today";

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: DropdownButton(
        iconEnabledColor: Colors.white,
        style: TextStyle(color: Colors.black),
        underline: Container(),
        value: dropDownValue,
        selectedItemBuilder: (context) {
          return <String>["Today", "1 week", "2 week", "1 month"].map((String value) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 10),
              child: Text(
                dropDownValue,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          }).toList();
        },
        items: <String>["Today", "1 week", "2 week", "1 month"].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 14.sf),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            dropDownValue = value;
            BlocProvider.of<ClientDetailsCubit>(context).filterMedications(value);
          });
        },
      ),
    );
  }
}
