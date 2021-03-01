import 'package:flutter/material.dart';

class MedicineType extends StatefulWidget {
  @override
  _MedicineTypeState createState() => _MedicineTypeState();
}

class _MedicineTypeState extends State<MedicineType> {
  var _selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Medicine Type",
          style: TextStyle(fontSize: 32),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              child: Image(
                image: AssetImage(_selectedImage == 0
                    ? "assets/images/heart_selected.png"
                    : "assets/images/heart.png"),
              ),
              onTap: () {
                setState(() {
                  _selectedImage = 0;
                });
              },
            ),
            Image(
              image: AssetImage("assets/images/dots.png"),
            ),
            Image(
              image: AssetImage("assets/images/sun.png"),
            ),
            Image(
              image: AssetImage("assets/images/tear.png"),
            ),
            Image(
              image: AssetImage("assets/images/moon.png"),
            ),
            Image(
              image: AssetImage("assets/images/shield.png"),
            ),
          ],
        ),
      ],
    );
  }
}
