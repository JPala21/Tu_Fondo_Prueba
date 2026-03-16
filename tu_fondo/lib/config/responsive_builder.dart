import 'package:flutter/material.dart';
import 'dart:math' as math;

class ResponsiveSign {
  final BuildContext context;
  late final double _width;
  late final double _height;
  late final Orientation _orientation;
  late final double _pixelRatio;

  ResponsiveSign(this.context) {
    final mediaQuery = MediaQuery.of(context);
    _width = mediaQuery.size.width;
    _height = mediaQuery.size.height;
    _orientation = mediaQuery.orientation;
    _pixelRatio = mediaQuery.devicePixelRatio;
  }

  double get width => _width;
  double get height => _height;
  Orientation get orientation => _orientation;

  bool get isMobile => _width < 600;
  bool get isTablet => _width >= 600 && _width < 1024;
  bool get isDesktop => _width >= 1024 && _width < 1440;
  bool get isLargeDesktop => _width >= 1440;

  double wp(double percent) => _width * percent;
  double hp(double percent) => _height * percent;

  double scale(double size) {
    double scaleFactor;
    if (_width >= 1920) {
      scaleFactor = (_width / 1920) * 1.2;
    } else if (_width >= 1024) {
      scaleFactor = (_width / 1920) * 1.1;
    } else if (_width >= 768) {
      scaleFactor = (_width / 1024) * 1.05;
    } else {
      scaleFactor = (_width / 375) * 0.9;
    }
    scaleFactor = scaleFactor.clamp(0.8, 1.4);
    return math.max(
      size * scaleFactor,
      _pixelRatio > 2 ? _pixelRatio * 0.75 : 8.0,
    );
  }
}

class ResponsiveBuilder<T> extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    ResponsiveSign responsive,
  )
  builder;

  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveSign(context);
    final result = builder(context, responsive);
    return result;
  }
}
