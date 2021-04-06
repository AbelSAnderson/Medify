import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/cubit/settings_cubit.dart';
import 'package:medify/scale.dart';
import 'package:medify/widgets/change_password_dialog.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _sliderValue = 1.5;
  var _switchValue = false;

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
                value: _switchValue,
                onChanged: (value) {
                  setState(() {
                    _switchValue = value;
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
          builder: (context) => ChangePasswordDialog(),
        );
      },
    );
  }
}
