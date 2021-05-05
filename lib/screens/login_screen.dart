import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:medify/cubit/login_cubit.dart';
import 'package:medify/cubit/nav_bar_cubit.dart';
import 'package:medify/cubit/reset_password_cubit.dart';
import 'package:medify/repositories/medication_event_repository.dart';
import 'package:medify/repositories/medication_info_repository.dart';
import 'package:medify/repositories/user_repository.dart';
import 'package:medify/scale.dart';
import 'package:medify/screens/register_screen.dart';
import 'package:medify/widgets/reset_password_dialog.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  var showPassword = false;

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
                        _loginButtonProvider(context),
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
          controller: emailController,
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
          controller: passwordController,
          obscureText: !showPassword,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: !showPassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
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
            builder: (context) => BlocProvider<ResetPasswordCubit>(
              create: (context) => ResetPasswordCubit(),
              child: ResetPasswordDialog(),
            ),
          );
        },
      ),
    );
  }

  Widget _loginButtonProvider(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      if (state is LoginInitial) {
        return _loginButton(context);
      } else if (state is LoginValidating) {
        return Center(child: CircularProgressIndicator.adaptive());
      } else if (state is LoginFailed) {
        return Column(children: [
          _loginButton(context),
          SizedBox(height: 12.5.sv),
          Text(
            state.errorMessage,
            style: TextStyle(
              fontSize: 14.sf,
              color: Colors.red,
            ),
          ),
        ]);
      } else if (state is LoginSucceeded) {
        WidgetsBinding.instance.addPostFrameCallback((_) => {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MultiRepositoryProvider(
                    providers: [
                      RepositoryProvider(
                        create: (context) => MedicationEventRepository(),
                      ),
                      RepositoryProvider(
                        create: (context) => MedicationInfoRepository(),
                      ),
                    ],
                    child: BlocProvider<NavBarCubit>(
                      create: (context) => NavBarCubit(RepositoryProvider.of<UserRepository>(context)),
                      child: MyHomePage(
                        title: 'Medify',
                      ),
                    ),
                  ),
                ),
              )
            });
        return Center(child: CircularProgressIndicator.adaptive());
      }
      return Container();
    });
  }

  Widget _loginButton(BuildContext context) {
    return Center(
      child: PlatformButton(
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.sf, color: Colors.white),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            BlocProvider.of<LoginCubit>(context).loginUser(emailController.text, passwordController.text);
          }
        },
        color: Theme.of(context).primaryColor,
        material: (context, platform) => MaterialRaisedButtonData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        cupertino: (context, platform) => CupertinoButtonData(padding: EdgeInsets.symmetric(horizontal: 10)),
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
              builder: (context) => BlocProvider<LoginCubit>(
                create: (context) => LoginCubit(RepositoryProvider.of<UserRepository>(context)),
                child: RegisterScreen(),
              ),
            ));
          },
        ),
      ],
    );
  }
}
