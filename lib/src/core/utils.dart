import 'package:flutter/material.dart';

extension StringX on String {
  String capitalize() => '${substring(0, 1).toUpperCase()}${substring(1)}';
}

extension ContextX on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get screenSize => mediaQuery.size;

  Orientation get orientation => mediaQuery.orientation;

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;
}
