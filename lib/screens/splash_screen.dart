import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/cubit/login_cubit.dart';
import 'package:medify/cubit/nav_bar_cubit.dart';
import 'package:medify/cubit/remember_me_cubit.dart';
import 'package:medify/repositories/medication_event_repository.dart';
import 'package:medify/repositories/medication_info_repository.dart';
import 'package:medify/repositories/user_repository.dart';
import 'package:medify/scale.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  final ImageProvider logo = const AssetImage("assets/launcher_icons/RXMedifyLogo.png");

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RememberMeCubit, RememberMeState>(
      listener: (context, state) {
        if (state is RememberMeSuccess) {
          _navigateToHome(context);
        }
        if (state is RememberMeFailure) {
          _navigateToLogin(context);
        }
      },
      builder: (context, state) {
        print("Builder: " + state.toString());
        if (state is RememberMeInitial) {
          BlocProvider.of<RememberMeCubit>(context).checkIfLoggedIn();
        }
        return Scaffold(
          body: _splashLayout(context),
        );
      },
    );
  }

  _navigateToLogin(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(RepositoryProvider.of<UserRepository>(context)),
          child: LoginScreen(),
        ),
      ),
      (Route<dynamic> route) => false,
    );
  }

  _splashLayout(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(3, 0),
          colors: [
            Theme.of(context).primaryColor,
            // TODO-FIX
            // Theme.of(context).accentColor,
          ],
        ),
      ),
      child: Center(
        child: Container(
          width: 200.sh,
          height: 200.sv,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: logo,
            ),
          ),
        ),
      ),
    );
  }

  _navigateToHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
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
              title: 'RX-Medify',
            ),
          ),
        ),
      ),
      (Route<dynamic> route) => false,
    );
  }
}
