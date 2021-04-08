import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:medify/constants.dart';
import 'package:medify/cubit/client_details_cubit.dart';
import 'package:medify/cubit/clients_cubit.dart';
import 'package:medify/database/models/medication_event.dart';
import 'package:medify/database/models/user.dart';
import 'package:medify/database/models/user_connection.dart';
import 'package:medify/scale.dart';

class ClientDetailsScreen extends StatelessWidget {
  final UserConnection userConnection;

  ClientDetailsScreen(this.userConnection);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userConnection.user.name),
        actions: [
          PlatformIconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              BlocProvider.of<ClientsCubit>(context).removeClient(userConnection);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: BlocBuilder<ClientDetailsCubit, ClientDetailsState>(
        builder: (context, state) {
          if (state is ClientDetailsInitial) {
            BlocProvider.of<ClientDetailsCubit>(context).loadClientMedications();
          }
          if (state is ClientDetailsLoading) {
            return Center(
              child: CircularProgressIndicator(),
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
