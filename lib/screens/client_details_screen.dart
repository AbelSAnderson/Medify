import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/constants.dart';
import 'package:medify/cubit/client_details_cubit.dart';
import 'package:medify/cubit/clients_cubit.dart';
import 'package:medify/database/models/medication_event.dart';
import 'package:medify/database/models/user.dart';

class ClientDetailsScreen extends StatelessWidget {
  final User user;

  ClientDetailsScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.firstName + " " + user.lastName),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              BlocProvider.of<ClientsCubit>(context).removeClient(user);
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
              child: Text("Error"),
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
            title: Text(med.medicationInfo.medication.brandName),
            subtitle: Text(formatDate(med.datetime, ["MM", " ", "d", ", ", "yyyy", " at ", "h", ":", "mm", "am"])),
            leading: Image(
              image: getMedTypeImage(med.medicationInfo.medicationType, false),
            ),
            trailing: med.medTaken ? Text("Taken") : Text("Not Taken"),
          ),
        );
      },
    );
  }
}
