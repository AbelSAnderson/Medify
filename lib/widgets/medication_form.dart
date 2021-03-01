import 'package:flutter/material.dart';
import 'package:medify/widgets/medicine_type.dart';

class MedicationForm extends StatefulWidget {
  @override
  _MedicationFormState createState() => _MedicationFormState();
}

class _MedicationFormState extends State<MedicationForm> {
  final _formKey = GlobalKey<FormState>();
  var repeatsValue = "Weekly";

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
                      value: repeatsValue,
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
                      items: <String>["Daily", "Weekly", "Bi-Weekly", "Monthly"]
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          repeatsValue = newValue;
                        });
                      }),
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
                  Text("Start Date*"),
                  SizedBox(height: 10),
                  Container(
                    alignment: Alignment.topRight,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1000),
                          lastDate: DateTime(3000),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Time*"),
                  SizedBox(height: 10),
                  Container(
                    alignment: Alignment.topRight,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.access_time),
                      onPressed: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  MedicineType(),
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
