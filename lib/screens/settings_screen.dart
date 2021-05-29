import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:medify/cubit/change_password_cubit.dart';
import 'package:medify/cubit/login_cubit.dart';
import 'package:medify/cubit/nav_bar_cubit.dart';
import 'package:medify/cubit/settings_cubit.dart';
import 'package:medify/repositories/medication_event_repository.dart';
import 'package:medify/repositories/medication_info_repository.dart';
import 'package:medify/repositories/user_repository.dart';
import 'package:medify/scale.dart';
import 'package:medify/widgets/change_password_dialog.dart';
import 'package:medify/widgets/confirmation_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _sliderValue = 1.5;
  var _termsURL = "https://www.websitepolicies.com/policies/view/4TSzq882";

  @override
  Widget build(BuildContext context) {
    _sliderValue = BlocProvider.of<SettingsCubit>(context).state.fontScaleFactor;
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sh, vertical: 12.sv),
          child: Column(
            children: [
              _fontSizeSection(),
              _caregiverModeSection(),
              _changePasswordSection(),
              _termsAndConditionsSection(),
              _logoutSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fontSizeSection() {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (previous, current) => previous.fontScaleFactor != current.fontScaleFactor,
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.sv),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Font Size",
                      style: TextStyle(fontSize: 18.sf),
                    ),
                  ),
                  Container(
                    width: 250.sh,
                    child: Slider.adaptive(
                      value: _sliderValue,
                      min: 1,
                      max: 2,
                      onChanged: (value) {
                        setState(() {
                          _sliderValue = value;
                        });
                        BlocProvider.of<SettingsCubit>(context).changeFontScaleFactor(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
              height: 0,
            ),
          ],
        );
      },
    );
  }

  Widget _caregiverModeSection() {
    return BlocConsumer<NavBarCubit, NavBarState>(
      listener: (context, state) {
        if (state.isError == true) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Error"),
            ),
          );
        }
      },
      buildWhen: (previous, current) => previous.showClients != current.showClients,
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.sv),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Caregiver Mode",
                    style: TextStyle(fontSize: 18.sf),
                  ),
                  Switch.adaptive(
                    activeColor: Theme.of(context).primaryColor,
                    value: state.showClients,
                    onChanged: (value) {
                      setState(() {
                        BlocProvider.of<NavBarCubit>(context).showClientsScreen(value);
                      });
                    },
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
              height: 0,
            ),
          ],
        );
      },
    );
  }

  Widget _changePasswordSection() {
    return InkWell(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.sv),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Change Password",
                  style: TextStyle(fontSize: 18.sf),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  size: 24.sf,
                ),
              ],
            ),
          ),
          Divider(
            thickness: 2,
            height: 0,
          ),
        ],
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => BlocProvider<ChangePasswordCubit>(
            create: (context) => ChangePasswordCubit(RepositoryProvider.of<UserRepository>(context)),
            child: ChangePasswordDialog(),
          ),
        );
      },
    );
  }

  Widget _termsAndConditionsSection() {
    return InkWell(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.sv),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Terms & Conditions",
                  style: TextStyle(fontSize: 18.sf),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  size: 24.sf,
                ),
              ],
            ),
          ),
          Divider(
            thickness: 2,
            height: 0,
          ),
        ],
      ),
      onTap: () {
        _launchTermsURL();
      },
    );
  }

  void _launchTermsURL() async {
    var canLaunchUrl = await canLaunch(_termsURL);
    if (canLaunchUrl) {
      await launch(_termsURL);
    }
  }

  Widget _logoutSection() {
    return InkWell(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.sv),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Logout",
                  style: TextStyle(fontSize: 18.sf),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  size: 24.sf,
                ),
              ],
            ),
          ),
          Divider(
            thickness: 2,
            height: 0,
          ),
        ],
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => ConfirmationDialog(
            confirmClicked: () => {
              //Phoenix (Flutter package) allows you to rebuild the entire widget tree (refreshes app)
              Phoenix.rebirth(context)
            },
            title: "Logout",
            message: "Are you sure you want to logout?",
            buttonTitle: "Logout",
          ),
        );
      },
    );
  }
}
