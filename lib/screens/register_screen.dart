import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:medify/cubit/login_cubit.dart';
import 'package:medify/scale.dart';
import 'package:medify/screens/login_screen.dart';

import 'home_screen.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final pharmacyNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 15.sv),
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
                      children: [
                        _nameField(),
                        SizedBox(height: 12.5.sv),
                        _emailField(),
                        SizedBox(height: 12.5.sv),
                        _passwordField(),
                        SizedBox(height: 12.5.sv),
                        _confirmPasswordField(),
                        SizedBox(height: 12.5.sv),
                        _pharmacyNumField(),
                        SizedBox(height: 12.5.sv),
                        _registerAsSectionProvider(context),
                        SizedBox(height: 12.5.sv),
                        _loginButtonSection(context),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
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
          maxLength: 50,
          style: TextStyle(fontSize: 16.sf),
          controller: nameController,
          decoration: InputDecoration(
            counterText: "",
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 32),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 14.sv, horizontal: 14),
          ),
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value.length < 1) return "Name field can't be empty";
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
          style: TextStyle(fontSize: 16.sf),
          controller: emailController,
          maxLength: 200,
          decoration: InputDecoration(
            isDense: true,
            counterText: "",
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 32),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 14.sv, horizontal: 14),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            final emailRegExp = RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
            if (!emailRegExp.hasMatch(value)) return "Invalid Email";
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
            "Password*",
            style: TextStyle(fontSize: 14.sf),
          ),
        ),
        SizedBox(height: 10.sv),
        TextFormField(
          maxLength: 200,
          style: TextStyle(fontSize: 16.sf),
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            counterText: "",
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
            "Confirm Password*",
            style: TextStyle(fontSize: 14.sf),
          ),
        ),
        SizedBox(height: 10.sv),
        TextFormField(
          maxLength: 200,
          style: TextStyle(fontSize: 16.sf),
          controller: confirmPasswordController,
          obscureText: true,
          decoration: InputDecoration(
            counterText: "",
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 32),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 14.sv, horizontal: 14),
          ),
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            if (passwordController.text != value) return "Passwords must match";
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
          maxLength: 200,
          style: TextStyle(fontSize: 16.sf),
          controller: pharmacyNumberController,
          decoration: InputDecoration(
            counterText: "",
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 32),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 14.sv, horizontal: 14),
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            var phoneRegExp = RegExp(r'^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$');
            if (value == "") return null;
            if (!phoneRegExp.hasMatch(value)) return "Invalid Phone Number";
            return null;
          },
        ),
      ],
    );
  }

  Widget _registerAsSectionProvider(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      if (state is LoginInitial) {
        return _registerAsSection(context);
      } else if (state is LoginValidating) {
        return Center(child: CircularProgressIndicator());
      } else if (state is LoginFailed) {
        return Column(children: [_registerAsSection(context), Text(state.errorMessage)]);
      } else if (state is LoginSucceeded) {
        WidgetsBinding.instance.addPostFrameCallback((_) => {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => MyHomePage(
                  title: 'Medify',
                ),
              ))
            });
        return Center(child: CircularProgressIndicator());
      }

      return Container();
    });
  }

  Widget _registerAsSection(BuildContext context) {
    return Column(
      children: [
        // Text(
        //   "Who do you want to register as?",
        //   style: TextStyle(fontSize: 14.sf),
        // ),
        // Text(
        //   "(You can change this later)",
        //   style: TextStyle(fontSize: 14.sf),
        // ),
        // SizedBox(height: 12.5.sv),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PlatformButton(
              child: Text(
                "Register as Client",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.sf, color: Colors.white),
              ),
              onPressed: () {
                BlocProvider.of<LoginCubit>(context).resetState();
                if (_formKey.currentState.validate()) {
                  BlocProvider.of<LoginCubit>(context).registerUser(nameController.text, emailController.text, passwordController.text, pharmacyNumberController.text, 0);
                }
              },
              cupertino: (context, platform) => CupertinoButtonData(padding: EdgeInsets.symmetric(horizontal: 10)),
              material: (context, platform) => MaterialRaisedButtonData(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
              ),
              color: Theme.of(context).primaryColor,
            ),
            PlatformButton(
              child: Text(
                "Register as Caregiver",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.sf, color: Colors.white),
              ),
              onPressed: () {
                BlocProvider.of<LoginCubit>(context).resetState();
                if (_formKey.currentState.validate()) {
                  BlocProvider.of<LoginCubit>(context).registerUser(nameController.text, emailController.text, passwordController.text, pharmacyNumberController.text, 1);
                }
              },
              cupertino: (context, platform) => CupertinoButtonData(padding: EdgeInsets.symmetric(horizontal: 10)),
              material: (context, platform) => MaterialRaisedButtonData(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }

  Widget _loginButtonSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(fontSize: 14.sf),
        ),
        TextButton(
          style: TextButton.styleFrom(),
          child: Text(
            "Login",
            style: TextStyle(fontSize: 14.sf),
          ),
          onPressed: () {
            BlocProvider.of<LoginCubit>(context).resetState();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
          },
        ),
      ],
    );
  }
}
