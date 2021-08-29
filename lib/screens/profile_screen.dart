import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:medify/cubit/add_caregiver_cubit.dart';
import 'package:medify/cubit/caregivers_cubit.dart';
import 'package:medify/cubit/edit_profile_cubit.dart';
import 'package:medify/cubit/medications_cubit.dart';
import 'package:medify/cubit/nav_bar_cubit.dart';
import 'package:medify/cubit/profile_cubit.dart';
import 'package:medify/cubit/settings_cubit.dart';
import 'package:medify/database1/model_queries/caregivers_queries.dart';
import 'package:medify/repositories/user_repository.dart';
import 'package:medify/screens/medications_screen.dart';
import 'package:medify/screens/settings_screen.dart';
import 'package:medify/widgets/edit_profile_dialog.dart';
import 'package:medify/scale.dart';
import 'package:medify/widgets/confirmation_dialog.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
        ),
        leading: PlatformIconButton(
          padding: EdgeInsets.all(0),
          icon: Icon(Icons.edit, color: Colors.white),
          onPressed: () {
            showDialog(
              context: context,
              builder: (newContext) => BlocProvider.value(
                value: BlocProvider.of<ProfileCubit>(context),
                child: BlocProvider<EditProfileCubit>(
                  create: (context) => EditProfileCubit(
                    RepositoryProvider.of<UserRepository>(context),
                  ),
                  child: EditProfileDialog(),
                ),
              ),
            );
          },
        ),
        actions: [
          PlatformIconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (newContext) => BlocProvider.value(
                  value: BlocProvider.of<NavBarCubit>(context),
                  child: SettingsScreen(),
                ),
              ));
            },
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileInitial) {
            var user = RepositoryProvider.of<UserRepository>(context).currentUser;
            BlocProvider.of<ProfileCubit>(context).loadProfile(user);
          }
          if (state is ProfileLoading) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is ProfileLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sh, vertical: 16.sv),
                    child: Text(
                      RepositoryProvider.of<UserRepository>(context).currentUser.name,
                      style: TextStyle(fontSize: 32.sf),
                      textAlign: TextAlign.center,
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
                                child: CircularProgressIndicator.adaptive(),
                              );
                            }
                            if (state is MedicationsLoaded) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Text(
                                      "Medications: ${state.medications.length}",
                                      style: TextStyle(fontSize: 20.sf),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: PlatformButton(
                                        child: Text(
                                          "View Medications",
                                          style: TextStyle(fontSize: 14.sf, color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (newContext) => BlocProvider.value(
                                                value: BlocProvider.of<MedicationsCubit>(context),
                                                child: MedicationsScreen(state.medications),
                                              ),
                                            ),
                                          );
                                        },
                                        material: (context, platform) => MaterialRaisedButtonData(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                                            ),
                                        cupertino: (context, platform) => CupertinoButtonData(padding: EdgeInsets.symmetric(horizontal: 10)),
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ],
                              );
                            }
                            if (state is MedicationsError) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "No Internet Connection.",
                                      style: TextStyle(fontSize: 18.sf),
                                    ),
                                    TextButton(
                                      child: Text("Try Again"),
                                      onPressed: () => BlocProvider.of<MedicationsCubit>(context).loadMedications(),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.sh, vertical: 16.sv),
                    child: Text(
                      "Caregivers",
                      style: TextStyle(fontSize: 24.sf),
                    ),
                  ),
                  _caregiversList(context),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.sh, vertical: 12.sv),
                    child: PlatformButton(
                      child: Text(
                        "Add Caregiver",
                        style: TextStyle(fontSize: 14.sf, color: Colors.white),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => BlocProvider<AddCaregiverCubit>(
                            create: (context) => AddCaregiverCubit(CaregiversQueries()),
                            child: AddCaregiverAlertDialog(),
                          ),
                        );
                      },
                      material: (context, platform) => MaterialRaisedButtonData(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                      ),
                      cupertino: (context, platform) => CupertinoButtonData(padding: EdgeInsets.symmetric(horizontal: 10)),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is ProfileError) {
            return Center(
              child: Text("Error"),
            );
          }
          return Container();
        },
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
          return Container(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        if (state is CaregiversLoaded) {
          if (state.caregivers.length > 0) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.35,
              child: RefreshIndicator(
                onRefresh: () => BlocProvider.of<CaregiversCubit>(context).loadCaregivers(),
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
                            "${caregiver.name}",
                            style: TextStyle(fontSize: 20.sf),
                          ),
                          trailing: PlatformIconButton(
                            padding: EdgeInsets.all(0),
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.red,
                              size: 35,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (newContext) => BlocProvider.value(
                                  value: BlocProvider.of<CaregiversCubit>(context),
                                  child: ConfirmationDialog(
                                    confirmClicked: () => BlocProvider.of<CaregiversCubit>(context).removeCaregiver(caregiver),
                                    title: "Remove Caregiver",
                                    message: "Are you sure you want to remove this caregiver?",
                                    buttonTitle: "Remove",
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height * 0.35,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You have no caregivers.",
                      style: TextStyle(fontSize: 18.sf),
                    ),
                    TextButton(
                      child: Text(
                        "Reload",
                        style: TextStyle(fontSize: 14.sf),
                      ),
                      onPressed: () => BlocProvider.of<CaregiversCubit>(context).loadCaregivers(),
                    ),
                  ],
                ),
              ),
            );
          }
        }
        return Container();
      },
    );
  }
}

class AddCaregiverAlertDialog extends StatelessWidget {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.sh, vertical: 20.sv),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.sh, vertical: 16.sv),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
      title: Text(
        "Add Caregiver",
        style: TextStyle(fontSize: 22.sf, color: Colors.black),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.sv, horizontal: 8.sh),
            child: _emailField(),
          ),
          SizedBox(height: 12.sv),
          BlocBuilder<AddCaregiverCubit, AddCaregiverState>(
            builder: (context, state) {
              if (state.isLoading) {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              return Column(
                children: [
                  _sendRequestButton(context),
                  state.response == ""
                      ? Container()
                      : Column(
                          children: [
                            SizedBox(height: 12.sv),
                            Text(state.response),
                          ],
                        ),
                ],
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

  Widget _sendRequestButton(BuildContext context) {
    return PlatformButton(
      child: Text(
        "Send Request",
        style: TextStyle(fontSize: 14.sf, color: Colors.white),
      ),
      onPressed: () {
        BlocProvider.of<AddCaregiverCubit>(context).addCaregiver(emailController.text);
      },
      material: (context, platform) => MaterialRaisedButtonData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
      ),
      cupertino: (context, platform) => CupertinoButtonData(padding: EdgeInsets.symmetric(horizontal: 10)),
      color: Theme.of(context).primaryColor,
    );
  }

  Widget _emailField() {
    return Container(
      width: 300.sh,
      child: TextFormField(
        controller: emailController,
        maxLength: 200,
        style: TextStyle(fontSize: 16.sf),
        decoration: InputDecoration(
          counterText: "",
          hintText: "Caregiver's email",
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
          contentPadding: EdgeInsets.symmetric(vertical: 14.sv, horizontal: 14),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
