import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:medify/scale.dart';
import 'package:medify/screens/home_screen.dart';
import 'package:medify/screens/register_screen.dart';
import 'package:medify/widgets/reset_password_dialog.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 30.sv),
                  child: Text(
                    "Medify",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 42.sf,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.sh),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _emailField(),
                        SizedBox(height: 20.sv),
                        _passwordField(),
                        _resetPasswordButton(context),
                        SizedBox(height: 20.sv),
                        _loginButton(context),
                        SizedBox(
                          height: 20.sv,
                        ),
                        _signUpButtonSection(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Email",
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
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            return null;
          },
        ),
      ],
    );
  }

  Widget _passwordField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Password",
            style: TextStyle(fontSize: 14.sf),
          ),
        ),
        SizedBox(height: 10.sv),
        TextFormField(
          style: TextStyle(fontSize: 16.sf),
          initialValue: "",
          obscureText: true,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 32),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 14.sv, horizontal: 14),
          ),
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            return null;
          },
        ),
      ],
    );
  }

  Widget _resetPasswordButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text(
          "Reset Password?",
          style: TextStyle(fontSize: 14.sf),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => ResetPasswordDialog(),
          );
        },
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.sf),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => MyHomePage(
                title: 'Medify',
              ),
            ));
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 22.sh),
        ),
      ),
    );
  }

  Widget _signUpButtonSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "New User?",
          style: TextStyle(fontSize: 14.sf),
        ),
        TextButton(
          style: TextButton.styleFrom(),
          child: Text(
            "Sign Up",
            style: TextStyle(fontSize: 14.sf),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => RegisterScreen(),
            ));
          },
        ),
      ],
    );
  }
}
