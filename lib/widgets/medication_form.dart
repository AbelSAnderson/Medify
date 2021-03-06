import 'package:flutter/material.dart';
import 'package:medify/widgets/medicine_type.dart';
import 'package:date_format/date_format.dart';
import 'medicine_type.dart';

class MedicationForm extends StatefulWidget {
  @override
  _MedicationFormState createState() => _MedicationFormState();
}

class _MedicationFormState extends State<MedicationForm> {
  final _formKey = GlobalKey<FormState>();
  var _repeatsValue = "Weekly";

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _medicineTypeIndex = 0;

  Future _selectDate(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1000),
      lastDate: DateTime(3000),
    ).then((value) => {
          if (value != null)
            {
              setState(() {
                _selectedDate = value;
              })
            }
        });
  }

  Future _selectTime(BuildContext context) async {
    await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    ).then((value) => {
          if (value != null)
            {
              setState(() {
                _selectedTime = value;
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name*",
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 32),
                      ),
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Repeats*"),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                      value: _repeatsValue,
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
                      items: <String>["Daily", "Weekly", "Bi-Weekly", "Monthly"].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          _repeatsValue = newValue;
                        });
                      }),
                  SizedBox(height: 20),
                  Text("Start Date*"),
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
                            child: Text(formatDate(_selectedDate, [mm, '-', dd, '-', yyyy])),
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
                  SizedBox(height: 20),
                  Text("Time*"),
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
                            child: Text(_selectedTime.format(context)),
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
                  SizedBox(height: 20),
                  Text(
                    "Pill Amount",
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
                  ),
                  SizedBox(height: 20),
                  MedicineType(onMedIndexChanged: (index) {
                    _medicineTypeIndex = index;
                    print("Form ID: " + index.toString());
                  }),
                  SizedBox(height: 20),
                ],
              ),
              RaisedButton(
                onPressed: () {
                  _formKey.currentState.validate();
                },
                child: Text("Add Medication"),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
