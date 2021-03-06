import 'package:flutter/material.dart';
import '../constants.dart';

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
            _medTypeImage(0, heartUrl, heartSelectedUrl),
            _medTypeImage(1, dotsUrl, dotsSelectedUrl),
            _medTypeImage(2, sunUrl, sunSelectedUrl),
            _medTypeImage(3, tearUrl, tearSelectedUrl),
            _medTypeImage(4, moonUrl, moonSelectedUrl),
            _medTypeImage(5, shieldUrl, shieldSelectedUrl),
          ],
        ),
      ],
    );
  }
}
