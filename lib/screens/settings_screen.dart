import 'package:flutter/material.dart';
import 'package:medify/scale.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _sliderValue = 50.0;
  var _switchValue = false;

  @override
  Widget build(BuildContext context) {
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
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Font Size",
            style: TextStyle(fontSize: 18.sf),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10.sh),
              child: Text(
                _sliderValue.toInt().toString() + "%",
                style: TextStyle(fontSize: 16.sf),
              ),
            ),
            Expanded(
              child: Slider.adaptive(
                value: _sliderValue,
                min: 1,
                max: 100,
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
              ),
            ),
          ],
        ),
        Divider(thickness: 2),
      ],
    );
  }

  Widget _caregiverModeSection() {
    return Column(
      children: [
        Row(
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
        Divider(thickness: 2),
      ],
    );
  }

  Widget _changePasswordSection() {
    return InkWell(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.sv),
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
          Divider(thickness: 2),
        ],
      ),
      onTap: () {
        //Show Change Password Dialog
      },
    );
  }
}
