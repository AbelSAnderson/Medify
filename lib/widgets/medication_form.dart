import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/cubit/medication_form_cubit.dart';
import 'package:medify/database/models/medication.dart';
import 'package:medify/widgets/medicine_type.dart';
import 'package:date_format/date_format.dart';
import 'medicine_type.dart';

class MedicationForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Medication medication;

  MedicationForm(this.medication);

  Future _selectDate(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 1000)),
    ).then((value) => {
          if (value != null) {BlocProvider.of<MedicationFormCubit>(context).changeStartDate(value)}
        });
  }

  Future _selectTime(BuildContext context) async {
    await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) => {
          if (value != null) {BlocProvider.of<MedicationFormCubit>(context).changeTime(value)}
        });
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MedicationFormCubit>(context).changeMedication(medication);
    return BlocBuilder<MedicationFormCubit, MedicationFormState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _nameField(state.medication.brandName),
                  SizedBox(height: 20),
                  _repeatsField(context, state.interval),
                  SizedBox(height: 20),
                  _startDateField(context, state.startDate),
                  SizedBox(height: 20),
                  _timeField(context, state.time),
                  SizedBox(height: 20),
                  _pillAmountField(context, state),
                  SizedBox(height: 20),
                  MedicineType(onMedIndexChanged: (index) {
                    BlocProvider.of<MedicationFormCubit>(context).changeMedicationType(index);
                  }),
                  SizedBox(height: 20),
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
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.topRight,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(medName),
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
          child: Text("Repeats*"),
        ),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: repeats ?? "Weekly",
          elevation: 16,
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(14),
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
              child: Text(value),
            );
          }).toList(),
          onChanged: (String newValue) {
            BlocProvider.of<MedicationFormCubit>(context).changeRepeats(newValue);
          },
        ),
      ],
    );
  }

  Widget _startDateField(BuildContext context, DateTime startDate) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text("Start Date*"),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: Container(
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(formatDate(startDate, [mm, '-', dd, '-', yyyy])),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    _selectDate(context);
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
          child: Text("Time*"),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            _selectTime(context);
          },
          child: Container(
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(time.format(context)),
                ),
                IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: () {
                    _selectTime(context);
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
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 32),
            ),
            contentPadding: EdgeInsets.all(10),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            return state.isPillAmountValid ? null : "Please enter a valid number";
          },
          onFieldSubmitted: (value) {
            BlocProvider.of<MedicationFormCubit>(context).changePillAmount(value);
          },
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            BlocProvider.of<MedicationFormCubit>(context).submitForm();
          }
        },
        child: Text("Add Medication"),
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          textStyle: TextStyle(
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}
