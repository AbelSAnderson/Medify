import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:medify/cubit/reset_password_cubit.dart';
import 'package:medify/scale.dart';

class ResetPasswordDialog extends StatelessWidget {

  final emailController = new TextEditingController();

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
          "Forgot your password?",
          style: TextStyle(fontSize: 22.sf),
          textAlign: TextAlign.center,
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.sh),
          child: Column(
            children: [
              _emailField(),
              SizedBox(height: 20.sv),
              _submitButtonProvider(context),
              _cancelButton(context),
            ],
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
        ),
      ],
    );
  }

  Widget _submitButtonProvider(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(builder: (context, state) {
      if (state is ResetInitial) {
        return _submitButton(context);
      } else if (state is ResetValidating) {
        return Center(child: CircularProgressIndicator.adaptive());
      } else if (state is ResetFailed) {
        return Column(children: [
          _submitButton(context),
          SizedBox(height: 12.5.sv),
          Text(
            state.errorMessage,
            style: TextStyle(
              fontSize: 14.sf,
              color: Colors.red,
            ),
          ),
        ]);
      } else if (state is ResetSucceeded) {
        return Center(child: Text("Reset successful. Please check your email for new password."));
      }
      return Container();
    });
  }

  Widget _submitButton(BuildContext context) {
    return Center(
      child: PlatformButton(
        child: Text(
          "Reset Password",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.sf, color: Colors.white),
        ),
        onPressed: () {
          BlocProvider.of<ResetPasswordCubit>(context).resetPassword(emailController.text);
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
          BlocProvider.of<ResetPasswordCubit>(context).resetState();
        },
      ),
    );
  }
}
