import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:medify/cubit/medication_form_cubit.dart';
import 'package:medify/cubit/nav_bar_cubit.dart';
import 'package:medify/database/models/medication.dart';
import 'package:medify/widgets/medicine_type.dart';
import 'package:date_format/date_format.dart';
import 'medicine_type.dart';
import 'package:medify/scale.dart';

class MedicationForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Medication medication;

  MedicationForm(this.medication);

  Future _selectDate(BuildContext context, DateTime initialDate) async {
    if (isCupertino(context)) {
      await showModalBottomSheet(
        context: context,
        builder: (context) => _cupertinoDatePicker(context, initialDate),
      );
    } else {
      await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
      ).then(
        (value) {
          if (value != null) {
            BlocProvider.of<MedicationFormCubit>(context).changeStartDate(value);
          }
        },
      );
    }
  }

  Future _selectTime(BuildContext context, TimeOfDay initialTime) async {
    if (isCupertino(context)) {
      await showModalBottomSheet(
        context: context,
        builder: (context) => _cupertinoTimePicker(context, initialTime),
      );
    } else {
      await showTimePicker(
        context: context,
        initialTime: initialTime,
      ).then(
        (value) {
          if (value != null) {
            BlocProvider.of<MedicationFormCubit>(context).changeTime(value);
          }
        },
      );
    }
  }

  Widget _cupertinoDatePicker(BuildContext context, DateTime initialDate) {
    var today = DateTime.now();
    return Container(
      height: 300.sv,
      child: CupertinoDatePicker(
        initialDateTime: initialDate,
        minimumDate: DateTime(today.year, today.month, today.day),
        maximumDate: DateTime.now().add(Duration(days: 365)),
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (value) {
          if (value != null) {
            BlocProvider.of<MedicationFormCubit>(context).changeStartDate(value);
          }
        },
      ),
    );
  }

  Widget _cupertinoTimePicker(BuildContext context, TimeOfDay initialTime) {
    //we dont need the date (just time)
    var initialDateTime = DateTime(2000, 1, 1, initialTime.hour, initialTime.minute);
    return Container(
      height: 300.sv,
      child: CupertinoDatePicker(
        initialDateTime: initialDateTime,
        mode: CupertinoDatePickerMode.time,
        onDateTimeChanged: (value) {
          var time = TimeOfDay(hour: value.hour, minute: value.minute);
          if (value != null) {
            BlocProvider.of<MedicationFormCubit>(context).changeTime(time);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //set medication to the medication that is being added
    BlocProvider.of<MedicationFormCubit>(context).changeMedication(medication);
    //initial value for pill amount textfield
    BlocProvider.of<MedicationFormCubit>(context).changePillAmount("");
    return BlocBuilder<MedicationFormCubit, MedicationFormState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.sv, horizontal: 16.sh),
              child: Wrap(
                runSpacing: 10.sv,
                children: [
                  _nameField(state.medication.brandName),
                  _repeatsField(context, state.interval),
                  _startDateField(context, state.startDate),
                  _timeField(context, state.time),
                  _pillAmountField(context, state),
                  MedicineType(onMedIndexChanged: (index) {
                    BlocProvider.of<MedicationFormCubit>(context).changeMedicationType(index);
                  }),
                  _submitButton(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _nameField(String medName) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Medication*",
            style: TextStyle(fontSize: 14.sf),
          ),
        ),
        SizedBox(height: 10.sv),
        Container(
          alignment: Alignment.topRight,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 14.sv, horizontal: 14),
                  child: Text(
                    medName,
                    style: TextStyle(fontSize: 14.sf),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _repeatsField(BuildContext context, String repeats) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Repeats*",
            style: TextStyle(fontSize: 14.sf),
          ),
        ),
        SizedBox(height: 10.sv),
        Container(
          height: 47.5.sv,
          child: DropdownButtonFormField<String>(
            value: repeats ?? "Weekly",
            style: TextStyle(fontSize: 14.sf, color: Colors.black),
            elevation: 16,
            isExpanded: true,
            iconSize: 24.sf,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 14),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 32,
                ),
              ),
            ),
            items: <String>["Daily", "Weekly", "Bi-Monthly", "Monthly"].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 14.sf),
                ),
              );
            }).toList(),
            onChanged: (String newValue) {
              BlocProvider.of<MedicationFormCubit>(context).changeRepeats(newValue);
            },
          ),
        ),
      ],
    );
  }

  Widget _startDateField(BuildContext context, DateTime startDate) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Start Date*",
            style: TextStyle(fontSize: 14.sf),
          ),
        ),
        SizedBox(height: 10.sv),
        GestureDetector(
          onTap: () {
            _selectDate(context, startDate);
          },
          child: Container(
            height: 50.sh,
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    formatDate(startDate, [mm, '-', dd, '-', yyyy]),
                    style: TextStyle(fontSize: 14.sf),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  iconSize: 24.sf,
                  onPressed: () {
                    _selectDate(context, startDate);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _timeField(BuildContext context, TimeOfDay time) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Time*",
            style: TextStyle(fontSize: 14.sf),
          ),
        ),
        SizedBox(height: 10.sv),
        GestureDetector(
          onTap: () {
            _selectTime(context, time);
          },
          child: Container(
            height: 50.sh,
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    time.format(context),
                    style: TextStyle(fontSize: 14.sf),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.access_time),
                  iconSize: 24.sf,
                  onPressed: () {
                    _selectTime(context, time);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _pillAmountField(BuildContext context, MedicationFormState state) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Pill Amount",
            style: TextStyle(fontSize: 14.sf),
          ),
        ),
        SizedBox(height: 10.sv),
        TextFormField(
          style: TextStyle(fontSize: 16.sf),
          initialValue: "",
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 32),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 14.sv, horizontal: 14),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            return state.isPillAmountValid ? null : "Please enter a valid number";
          },
          onChanged: (value) => BlocProvider.of<MedicationFormCubit>(context).changePillAmount(value),
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return Center(
      child: PlatformButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            BlocProvider.of<MedicationFormCubit>(context).submitForm(context);
            BlocProvider.of<NavBarCubit>(context).updateIndex(0);
            Navigator.of(context).pop();
          }
        },
        child: Text(
          "Add Medication",
          style: TextStyle(fontSize: 14.sf, color: Colors.white),
        ),
        cupertino: (context, platform) => CupertinoButtonData(padding: EdgeInsets.symmetric(horizontal: 10)),
        material: (context, platform) => MaterialRaisedButtonData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
