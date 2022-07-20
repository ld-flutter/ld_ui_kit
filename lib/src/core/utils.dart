import 'package:flutter/material.dart';

extension StringX on String {
  String capitalize() => '${substring(0, 1).toUpperCase()}${substring(1)}';

  bool deepContains(Object? other) =>
      other != null &&
      other is String &&
      toLowerCase().contains(other.toLowerCase());
}

extension ContextX on BuildContext {
  MediaQueryData getMediaQuery() => MediaQuery.of(this);

  Size getScreenSize() => getMediaQuery().size;

  Orientation getOrientation() => getMediaQuery().orientation;

  ThemeData getTheme() => Theme.of(this);

  ColorScheme getColorScheme() => getTheme().colorScheme;

  TextTheme getTextTheme() => getTheme().textTheme;
}
