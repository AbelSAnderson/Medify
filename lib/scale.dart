import 'dart:ui';

import 'package:flutter/material.dart';

/// A class to help scale the original UI to achieve the same UI on bigger or smaller screens.
class Scale {
  static Size size;
  static Size _deviceScreenSize;

  static num get _horizontallyScaleFactor {
    return _deviceScreenSize.width / size.width;
  }

  static num get _verticallyScaleFactor {
    return _deviceScreenSize.height / size.height;
  }

  static num get _fontScaleFactor {
    var deviceSize = (_deviceScreenSize.width + _deviceScreenSize.height);
    var originalSize = (size.width + size.height);
    return deviceSize / originalSize;
  }

  static bool get _isMobile {
    return _deviceScreenSize.shortestSide < 600;
  }

  /// Setup the screen with a [context] and the [size] you will use.
  /// [size] refers to the size of the original device you create the UI for.
  static void setup(BuildContext context, Size screenSize) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    _deviceScreenSize = mediaQuery.size;
    size = screenSize;
  }

  /// Get the number scaled horizontally.
  static num scaleHorizontally(num number) {
    num newNumber = number * _horizontallyScaleFactor;
    return _isMobile ? newNumber : number * 1.0;
  }

  /// Get the number scaled vertically.
  static num scaleVertically(num number) {
    num newNumber = number * _verticallyScaleFactor;
    return _isMobile ? newNumber : number * 1.0;
  }

  /// Get the font scaled.
  static num scaleFont(num number) {
    num newNumber = number * _fontScaleFactor;
    return _isMobile ? newNumber : number * 1.0;
  }
}

/// An extension to make it easier to apply scale on number.
extension ScreenExtension on num {
  /// Get the number scaled horizontally.
  num get sh {
    return Scale.scaleHorizontally(this);
  }

  /// Get the number scaled vertically.
  num get sv {
    return Scale.scaleVertically(this);
  }

  /// Get the font scaled.
  num get sf {
    return Scale.scaleFont(this);
  }
}
