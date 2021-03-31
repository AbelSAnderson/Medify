import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/cubit/add_caregiver_cubit.dart';
import 'package:medify/cubit/caregivers_cubit.dart';
import 'package:medify/cubit/medications_cubit.dart';
import 'package:medify/database/models/user_connection.dart';
import 'package:medify/screens/medications_screen.dart';
import 'package:medify/screens/settings_screen.dart';
import 'package:medify/widgets/edit_profile_dialog.dart';
import 'package:medify/widgets/remove_caregiver_dialog.dart';
import 'package:medify/widgets/search_bar.dart';
import 'package:medify/scale.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
        ),
        leading: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => EditProfileDialog(),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SettingsScreen(),
              ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sh, vertical: 16.sv),
              child: Text(
                "Jane Smith",
                style: TextStyle(fontSize: 32.sf),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sh, vertical: 16.sv),
              child: Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.sv),
                  child: BlocBuilder<MedicationsCubit, MedicationsState>(
                    builder: (context, state) {
                      if (state is MedicationsInitial) {
                        BlocProvider.of<MedicationsCubit>(context).loadMedications();
                      }
                      if (state is MedicationsLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is MedicationsLoaded) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Medications: ${state.medications.length}",
                              style: TextStyle(fontSize: 20.sf),
                            ),
                            ElevatedButton(
                              child: Text(
                                "View Medications",
                                style: TextStyle(fontSize: 14.sf),
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MedicationsScreen(state.medications)));
                              },
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sh, vertical: 16.sv),
              child: Text(
                "Caregivers",
                style: TextStyle(fontSize: 24.sf),
              ),
            ),
            _caregiversList(context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.sh, vertical: 12.sv),
              child: ElevatedButton(
                child: Text(
                  "Add Caregiver",
                  style: TextStyle(fontSize: 14.sf),
                ),
                onPressed: () {
                  showModal(
                    context: context,
                    configuration: FadeScaleTransitionConfiguration(
                      transitionDuration: Duration(milliseconds: 500),
                      reverseTransitionDuration: Duration(milliseconds: 300),
                    ),
                    builder: (context) => AddCaregiverAlertDialog(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _caregiversList(BuildContext context) {
    return BlocBuilder<CaregiversCubit, CaregiversState>(
      builder: (context, state) {
        if (state is CaregiversInitial) {
          BlocProvider.of<CaregiversCubit>(context).loadCaregivers();
        }
        if (state is CaregiversLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CaregiversLoaded) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.35,
            child: ListView.builder(
              itemCount: state.caregivers.length,
              itemBuilder: (context, index) {
                var caregiver = state.caregivers[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.sh),
                  child: Container(
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
                    child: ListTile(
                      title: Text(
                        "${caregiver.firstName} ${caregiver.lastName}",
                        style: TextStyle(fontSize: 20.sf),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 35,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => RemoveCaregiverDialog(),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}

class AddCaregiverAlertDialog extends StatelessWidget {
  Widget _tileTrailingIcon(BuildContext context, Status status) {
    if (status == Status.connected) {
      return IconButton(
        icon: Icon(
          Icons.add_circle,
          color: Theme.of(context).primaryColor,
          size: 30.sf,
        ),
        onPressed: () {},
      );
    } else if (status == Status.requested) {
      return IconButton(
        icon: Icon(
          Icons.check_circle,
          color: Theme.of(context).accentColor,
          size: 30.sf,
        ),
        onPressed: () {},
      );
    } else {
      return IconButton(
        icon: Icon(
          Icons.cancel,
          color: Colors.red,
          size: 30.sf,
        ),
        onPressed: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.sh, vertical: 20.sv),
      contentPadding: EdgeInsets.symmetric(horizontal: 10.sh, vertical: 10.sv),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SearchBar(
            onSearch: (inputText) {},
          ),
          BlocBuilder<AddCaregiverCubit, AddCaregiverState>(
            builder: (context, state) {
              if (state is AddCaregiverInitial) {
                BlocProvider.of<AddCaregiverCubit>(context).searchForCaregiver("");
              }
              if (state is AddCaregiverLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is AddCaregiverLoaded) {
                print(state.caregivers.length);
                return Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: ListView.builder(
                    itemCount: state.caregivers.length,
                    itemBuilder: (context, index) {
                      var caregiver = state.caregivers[index];
                      return ListTile(
                        title: Text(
                          caregiver.user.firstName,
                          style: TextStyle(fontSize: 20.sf),
                        ),
                        subtitle: Text(
                          caregiver.user.lastName,
                          style: TextStyle(fontSize: 16.sf),
                        ),
                        trailing: _tileTrailingIcon(context, caregiver.status),
                      );
                    },
                  ),
                );
              }
              return SizedBox(
                height: 30,
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              child: Text(
                "Close",
                style: TextStyle(fontSize: 14.sf),
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
            ),
          ),
        ],
      ),
    );
  }
}
