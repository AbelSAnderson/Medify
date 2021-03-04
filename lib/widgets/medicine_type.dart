import 'package:flutter/material.dart';

class MedicineType extends StatefulWidget {
  @override
  MedicineTypeState createState() => MedicineTypeState();

  final Function onMedIndexChanged;

  MedicineType({@required this.onMedIndexChanged});
}

class MedicineTypeState extends State<MedicineType> {
  var _selectedImage = 0;

  Widget _medTypeImage(int medIndex, String imageUrl, String imageSelectedUrl) {
    return GestureDetector(
      child: Image(
        image: AssetImage(_selectedImage == medIndex ? imageSelectedUrl : imageUrl),
      ),
      onTap: () {
        setState(() {
          widget.onMedIndexChanged(_selectedImage = medIndex);
        });
      },
    );
  }

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
            _medTypeImage(0, "assets/images/heart.png", "assets/images/heart_selected.png"),
            _medTypeImage(1, "assets/images/dots.png", "assets/images/dots_selected.png"),
            _medTypeImage(2, "assets/images/sun.png", "assets/images/sun_selected.png"),
            _medTypeImage(3, "assets/images/tear.png", "assets/images/tear_selected.png"),
            _medTypeImage(4, "assets/images/moon.png", "assets/images/moon_selected.png"),
            _medTypeImage(5, "assets/images/shield.png", "assets/images/shield_selected.png"),
          ],
        ),
      ],
    );
  }
}
