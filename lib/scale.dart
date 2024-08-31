import 'package:flutter/material.dart';

/// A class to help scale the original UI to achieve the same UI on bigger or smaller screens.
class Scale {
  late final Size size;
  late final Size _deviceScreenSize;

  bool isSetup = false;
  static Scale _singleton = Scale._init();

  factory Scale() {
    return _singleton;
  }

  Scale._init();

  double get _horizontallyScaleFactor {
    return _deviceScreenSize.shortestSide / size.shortestSide;
  }

  double get _verticallyScaleFactor {
    return _deviceScreenSize.longestSide / size.longestSide;
  }

  double get _fontScaleFactor {
    var deviceSize =
        (_deviceScreenSize.shortestSide + _deviceScreenSize.longestSide);
    var originalSize = (size.shortestSide + size.longestSide);
    return deviceSize / originalSize;
  }

  bool get isMobile {
    return _deviceScreenSize.shortestSide < 600;
  }

  /// Setup the screen with a [context] and the [size] you will use.
  /// [size] refers to the size of the original device you create the UI for.
  /// This Must always be called before any other method on this class
  void setup(BuildContext context, Size screenSize) {
    // TODO-FIX Why does this hit twice?
    if (isSetup) return;

    final MediaQueryData mediaQuery = MediaQuery.of(context);
    _deviceScreenSize = mediaQuery.size;
    size = screenSize;
    isSetup = true;
  }

  /// Get the number scaled horizontally.
  double scaleHorizontally(num number) {
    final newNumber = number * _horizontallyScaleFactor;
    return isMobile ? newNumber : number * 1.0;
  }

  /// Get the number scaled vertically.
  double scaleVertically(num number) {
    final newNumber = number * _verticallyScaleFactor;
    return isMobile ? newNumber : number * 1.0;
  }

  /// Get the font scaled.
  double scaleFont(num number) {
    final newNumber = number * _fontScaleFactor;
    return isMobile ? newNumber : number * 1.0;
  }
}

/// An extension to make it easier to apply scale on number.
extension ScreenExtension on num {
  /// Get the number scaled horizontally.
  double get sh {
    return Scale().scaleHorizontally(this);
  }

  /// Get the number scaled vertically.
  double get sv {
    return Scale().scaleVertically(this);
  }

  /// Get the font scaled.
  double get sf {
    return Scale().scaleFont(this);
  }
}
