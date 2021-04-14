import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:medify/cubit/change_password_cubit.dart';
import 'package:medify/scale.dart';

class ChangePasswordDialog extends StatefulWidget {
  @override
  _ChangePasswordDialogState createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final _formKey = GlobalKey<FormState>();

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  var showOldPassword = false;
  var showNewPassword = false;
  var showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.sh, vertical: 20.sv),
      contentPadding: EdgeInsets.symmetric(horizontal: 10.sh, vertical: 10.sv),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.sv),
        child: Text(
          "Change Password",
          style: TextStyle(fontSize: 22.sf, color: Colors.blue),
          textAlign: TextAlign.center,
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.sh),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _oldPasswordField(),
                SizedBox(height: 20.sv),
                _newPasswordField(),
                SizedBox(height: 20.sv),
                _confirmPasswordField(),
                SizedBox(height: 20.sv),
                BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                  builder: (context, state) {
                    if (state is ChangePasswordLoading) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    if (state is ChangePasswordSucceeded) {
                      return Column(
                        children: [
                          _submitButton(context),
                          SizedBox(height: 12.5.sv),
                          Text(
                            "Password changed successfully.",
                            style: TextStyle(fontSize: 14.sf),
                          ),
                        ],
                      );
                    }
                    if (state is ChangePasswordFailed) {
                      return Column(
                        children: [
                          _submitButton(context),
                          SizedBox(height: 12.5.sv),
                          Text(
                            state.errorMsg,
                            style: TextStyle(fontSize: 14.sf, color: Colors.red),
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
        ),
      ),
    );
  }

  Widget _oldPasswordField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Old Password",
            style: TextStyle(fontSize: 14.sf),
          ),
        ),
        SizedBox(height: 10.sv),
        TextFormField(
          style: TextStyle(fontSize: 16.sf),
          controller: oldPasswordController,
          obscureText: !showOldPassword,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: !showOldPassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
              onPressed: () {
                setState(() {
                  showOldPassword = !showOldPassword;
                });
              },
            ),
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 32),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 14.sv, horizontal: 14),
          ),
          keyboardType: TextInputType.visiblePassword,
        ),
      ],
    );
  }

  Widget _newPasswordField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "New Password",
            style: TextStyle(fontSize: 14.sf),
          ),
        ),
        SizedBox(height: 10.sv),
        TextFormField(
          controller: newPasswordController,
          style: TextStyle(fontSize: 16.sf),
          obscureText: !showNewPassword,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: !showNewPassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
              onPressed: () {
                setState(() {
                  showNewPassword = !showNewPassword;
                });
              },
            ),
            errorMaxLines: 2,
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 32),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 14.sv, horizontal: 14),
          ),
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            if (value.length < 8) return "Passwords must be 8 or more characters in length";
            return null;
          },
        ),
      ],
    );
  }

  Widget _confirmPasswordField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Confirm Password",
            style: TextStyle(fontSize: 14.sf),
          ),
        ),
        SizedBox(height: 10.sv),
        TextFormField(
          maxLength: 200,
          style: TextStyle(fontSize: 16.sf),
          initialValue: "",
          obscureText: !showConfirmPassword,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: !showConfirmPassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
              onPressed: () {
                setState(() {
                  showConfirmPassword = !showConfirmPassword;
                });
              },
            ),
            counterText: "",
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 32),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 14.sv, horizontal: 14),
          ),
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            if (newPasswordController.text != value) return "Passwords must match";
            return null;
          },
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return Center(
      child: PlatformButton(
        child: Text(
          "Change Password",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.sf, color: Colors.white),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            BlocProvider.of<ChangePasswordCubit>(context).changePassword(oldPasswordController.text, newPasswordController.text);
          }
        },
        cupertino: (context, platform) => CupertinoButtonData(padding: EdgeInsets.symmetric(horizontal: 10)),
        material: (context, platform) => MaterialRaisedButtonData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        color: Theme.of(context).primaryColor,
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
