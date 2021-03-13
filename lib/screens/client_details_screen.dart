import 'package:flutter/material.dart';

class ClientDetailsScreen extends StatefulWidget {
  @override
  _ClientDetailsScreenState createState() => _ClientDetailsScreenState();
}

class _ClientDetailsScreenState extends State<ClientDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Client Details"),
      ),
      body: Center(
        child: Text("Client Details Screen"),
      ),
    );
  }
}
