import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:medify/cubit/login_cubit.dart';
import 'package:medify/cubit/nav_bar_cubit.dart';
import 'package:medify/repositories/medication_event_repository.dart';
import 'package:medify/repositories/medication_info_repository.dart';
import 'package:medify/repositories/user_repository.dart';
import 'package:medify/scale.dart';
import 'package:medify/screens/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final pharmacyNumberController = TextEditingController();

  var showPassword = false;
  var showConfirmPassword = false;

  var _termsURL = "https://www.websitepolicies.com/policies/view/4TSzq882";
  var _privacyURL = "https://www.websitepolicies.com/policies/view/yamgMFnO";

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
                    "RX-Medify",
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
                        _termsAndConditionsSection(context),
                        SizedBox(height: 6.5.sv),
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
            contentPadding:
                EdgeInsets.symmetric(vertical: 14.sv, horizontal: 14),
          ),
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value != null && value.length < 1)
              return "Name field can't be empty";
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
            contentPadding:
                EdgeInsets.symmetric(vertical: 14.sv, horizontal: 14),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            final emailRegExp = RegExp(
                r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
            if (value != null && !emailRegExp.hasMatch(value))
              return "Invalid Email";
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
          obscureText: !showPassword,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: !showPassword
                  ? Icon(Icons.visibility)
                  : Icon(Icons.visibility_off),
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
            ),
            counterText: "",
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 32),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 14.sv, horizontal: 14),
          ),
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            if (value != null && value.length < 8)
              return "Passwords must be 8 or more characters in length";
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
          obscureText: !showConfirmPassword,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: !showConfirmPassword
                  ? Icon(Icons.visibility)
                  : Icon(Icons.visibility_off),
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
            contentPadding:
                EdgeInsets.symmetric(vertical: 14.sv, horizontal: 14),
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
            contentPadding:
                EdgeInsets.symmetric(vertical: 14.sv, horizontal: 14),
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            var phoneRegExp =
                RegExp(r'^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$');
            if (value == "") return null;
            if (value != null && !phoneRegExp.hasMatch(value))
              return "Invalid Phone Number";
            return null;
          },
        ),
      ],
    );
  }

  Widget _termsAndConditionsSection(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(
          text: "By signing up, you agree to the ",
          style: TextStyle(color: Colors.black, fontSize: 14.0.sf),
          children: [
            TextSpan(
              text: "Terms & Conditions",
              style: TextStyle(color: Colors.blue, fontSize: 14.0.sf),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _launchURL(_termsURL);
                },
            ),
            TextSpan(
              text: " and ",
              style: TextStyle(color: Colors.black, fontSize: 14.0.sf),
            ),
            TextSpan(
              text: "Privacy Policy",
              style: TextStyle(color: Colors.blue, fontSize: 14.0.sf),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _launchURL(_privacyURL);
                },
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    var canLaunchUrl = await canLaunch(url);
    if (canLaunchUrl) {
      await launch(url);
    }
  }

  Widget _registerAsSectionProvider(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      if (state is LoginInitial) {
        return _registerAsSection(context);
      } else if (state is LoginValidating) {
        return Center(child: CircularProgressIndicator.adaptive());
      } else if (state is LoginFailed) {
        return Column(children: [
          _registerAsSection(context),
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
        WidgetsBinding.instance.addPostFrameCallback((_) {
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
                  create: (context) => NavBarCubit(
                      RepositoryProvider.of<UserRepository>(context)),
                  child: MyHomePage(
                    title: 'RX-Medify',
                  ),
                ),
              ),
            ),
          );
        });
        return Center(child: CircularProgressIndicator.adaptive());
      }

      return Container();
    });
  }

  Widget _registerAsSection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PlatformElevatedButton(
              child: Text(
                "Register as Client",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.sf, color: Colors.white),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<LoginCubit>(context).registerUser(
                      nameController.text,
                      emailController.text,
                      passwordController.text,
                      pharmacyNumberController.text,
                      0);
                }
              },
              cupertino: (context, platform) => CupertinoElevatedButtonData(
                padding: EdgeInsets.symmetric(horizontal: 10),
              ),
              material: (context, platform) => MaterialElevatedButtonData(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                ),
              ),
              color: Theme.of(context).primaryColor,
            ),
            PlatformElevatedButton(
              child: Text(
                "Register as Caregiver",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.sf, color: Colors.white),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<LoginCubit>(context).registerUser(
                      nameController.text,
                      emailController.text,
                      passwordController.text,
                      pharmacyNumberController.text,
                      1);
                }
              },
              cupertino: (context, platform) => CupertinoElevatedButtonData(
                  padding: EdgeInsets.symmetric(horizontal: 10)),
              material: (context, platform) => MaterialElevatedButtonData(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                ),
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
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => BlocProvider<LoginCubit>(
                create: (context) =>
                    LoginCubit(RepositoryProvider.of<UserRepository>(context)),
                child: LoginScreen(),
              ),
            ));
          },
        ),
      ],
    );
  }
}
