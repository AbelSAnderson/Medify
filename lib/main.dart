import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //create custom color swatch for flutter to use on material componenets
    const Map<int, Color> colors = {
      50: Color.fromRGBO(1, 105, 255, 0.1),
      100: Color.fromRGBO(1, 105, 255, 0.2),
      200: Color.fromRGBO(1, 105, 255, 0.3),
      300: Color.fromRGBO(1, 105, 255, 0.4),
      400: Color.fromRGBO(1, 105, 255, 0.5),
      500: Color.fromRGBO(1, 105, 255, 0.6),
      600: Color.fromRGBO(1, 105, 255, 0.7),
      700: Color.fromRGBO(1, 105, 255, 0.8),
      800: Color.fromRGBO(1, 105, 255, 0.9),
      900: Color.fromRGBO(1, 105, 255, 1),
    };
    return MaterialApp(
      title: 'Medify',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: MaterialColor(0xFF0169FF, colors),
        //primaryColor: Color.fromRGBO(1, 105, 255, 1),
        accentColor: Color.fromRGBO(230, 0, 233, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Medify'),
    );
  }
}
