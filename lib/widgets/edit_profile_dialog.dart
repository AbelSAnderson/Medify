import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/cubit/edit_profile_cubit.dart';
import 'package:medify/cubit/profile_cubit.dart';
import 'package:medify/scale.dart';

class EditProfileDialog extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController(
      text:
          "q1w2d3gz"); //need this unique value because widget keeps rebuilding resetting text
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.sh, vertical: 20.sv),
      contentPadding: EdgeInsets.symmetric(horizontal: 10.sh, vertical: 10.sv),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.sv),
        child: Text(
          "Edit Details",
          style: TextStyle(fontSize: 22.sf, color: Colors.blue),
          textAlign: TextAlign.center,
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) {
              var user = state.user;
              // widget keeps rebuilding when changing text fields focus - this makes sure the values don't keep resetting
              // Note: The value can be anything that the user won't enter by mistake lol
              if (nameController.text == "q1w2d3gz") {
                nameController.text = user.name ?? "";
                emailController.text = user.email ?? "";
                phoneController.text = user.pharmacyNumber ?? "";
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.sh),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _nameField(),
                      SizedBox(height: 20.sv),
                      _emailField(),
                      SizedBox(height: 20.sv),
                      _pharmacyNumField(),
                      SizedBox(height: 20.sv),
                      BlocBuilder<EditProfileCubit, EditProfileState>(
                        builder: (context, state) {
                          if (state is EditProfileLoading) {
                            return Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          }
                          if (state is EditProfileSucceeded) {
                            return Column(
                              children: [
                                _submitButton(context),
                                SizedBox(height: 12.5.sv),
                                Text(
                                  "Profile edited successfully.",
                                  style: TextStyle(fontSize: 14.sf),
                                ),
                              ],
                            );
                          }
                          if (state is EditProfileFailed) {
                            return Column(
                              children: [
                                _submitButton(context),
                                SizedBox(height: 12.5.sv),
                                Text(
                                  state.errorMsg,
                                  style: TextStyle(
                                      fontSize: 14.sf, color: Colors.red),
                                ),
                              ],
                            );
                          }
                          return _submitButton(context);
                        },
                      ),
                      _cancelButton(context),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _nameField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Full Name*",
            style: TextStyle(fontSize: 14.sf),
          ),
        ),
        SizedBox(height: 10.sv),
        TextFormField(
          controller: nameController,
          maxLength: 50,
          style: TextStyle(fontSize: 16.sf),
          decoration: InputDecoration(
            counterText: "",
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 32),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 14.sv, horizontal: 14),
          ),
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value != null && value.length < 1) return "Name field can't be empty";
            return null;
          },
        ),
      ],
    );
  }

  Widget _emailField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Email*",
            style: TextStyle(fontSize: 14.sf),
          ),
        ),
        SizedBox(height: 10.sv),
        TextFormField(
          controller: emailController,
          maxLength: 200,
          style: TextStyle(fontSize: 16.sf),
          decoration: InputDecoration(
            counterText: "",
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 32),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 14.sv, horizontal: 14),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            final emailRegExp = RegExp(
                r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
            if (value != null && !emailRegExp.hasMatch(value)) return "Invalid Email";
            return null;
          },
        ),
      ],
    );
  }

  Widget _pharmacyNumField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Doctor / Pharmacy Phone",
            style: TextStyle(fontSize: 14.sf),
          ),
        ),
        SizedBox(height: 10.sv),
        TextFormField(
          controller: phoneController,
          maxLength: 200,
          style: TextStyle(fontSize: 16.sf),
          decoration: InputDecoration(
            counterText: "",
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 32),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 14.sv, horizontal: 14),
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            var phoneRegExp =
                RegExp(r'^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$');
            if (value == "") return null;
            if (value != null && !phoneRegExp.hasMatch(value)) return "Invalid Phone Number";
            return null;
          },
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text(
          "Save",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.sf),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            var user =
                (BlocProvider.of<ProfileCubit>(context).state as ProfileLoaded)
                    .user;
            user.name = nameController.text;
            user.email = emailController.text;
            user.pharmacyNumber = phoneController.text;
            BlocProvider.of<EditProfileCubit>(context).editProfileDetails(user);
          }
        },
        style: ElevatedButton.styleFrom(
          // TODO-FIX
          // primary: Theme.of(context).primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 16.sh),
        ),
      ),
    );
  }

  Widget _cancelButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: Text(
          "Cancel",
          style: TextStyle(fontSize: 14.sf),
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
        },
      ),
    );
  }
}
