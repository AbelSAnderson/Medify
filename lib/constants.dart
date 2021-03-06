import 'package:flutter/material.dart';

const String SUCCESS_MESSAGE = " You will be contacted by us very soon.";
const heartUrl = "assets/images/heart.png";
const dotsUrl = "assets/images/dots.png";
const sunUrl = "assets/images/sun.png";
const tearUrl = "assets/images/tear.png";
const moonUrl = "assets/images/moon.png";
const shieldUrl = "assets/images/shield.png";

const heartSelectedUrl = "assets/images/heart_selected.png";
const dotsSelectedUrl = "assets/images/dots_selected.png";
const sunSelectedUrl = "assets/images/sun_selected.png";
const tearSelectedUrl = "assets/images/tear_selected.png";
const moonSelectedUrl = "assets/images/moon_selected.png";
const shieldSelectedUrl = "assets/images/shield_selected.png";

AssetImage getMedTypeImage(int imageId, bool selected) {
  var imageUrl = "";
  switch (imageId) {
    case 0:
      imageUrl = !selected ? heartUrl : heartSelectedUrl;
      break;
    case 1:
      imageUrl = !selected ? dotsUrl : dotsSelectedUrl;
      break;
    case 2:
      imageUrl = !selected ? sunUrl : sunSelectedUrl;
      break;
    case 3:
      imageUrl = !selected ? tearUrl : tearSelectedUrl;
      break;
    case 4:
      imageUrl = !selected ? moonUrl : moonSelectedUrl;
      break;
    case 5:
      imageUrl = !selected ? shieldUrl : shieldSelectedUrl;
      break;
    default:
      imageUrl = selected ? heartUrl : heartSelectedUrl;
      break;
  }
  return AssetImage(imageUrl);
}
