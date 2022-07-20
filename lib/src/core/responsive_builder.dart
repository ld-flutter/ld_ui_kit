import 'package:flutter/material.dart';
import 'package:ld_ui_kit/ld_ui_kit.dart';

typedef ResponsiveWidgetBuilder = Widget Function(
    BuildContext context, ScreenType screenType);

enum ScreenType {
  mobile(300),
  tablet(550),
  desktop(950);

  final double minWidth;

  const ScreenType(this.minWidth);
}

extension ResponsiveX on BuildContext {
  ScreenType get screenType {
    final w = getScreenSize().shortestSide;

    return ScreenType.values.lastWhere(
      (type) => w >= type.minWidth,
      orElse: () => ScreenType.mobile,
    );
  }
}

class Responsive<T> {
  final T mobile;
  final T tablet;
  final T desktop;

  Responsive._(
      {required this.mobile, required this.tablet, required this.desktop});

  factory Responsive.when(
      {required T mobile, required T tablet, required T desktop}) {
    return Responsive._(mobile: mobile, tablet: tablet, desktop: desktop);
  }

  factory Responsive.maybeWhen({
    required T orElse,
    T? mobile,
    T? tablet,
    T? desktop,
  }) {
    return Responsive._(
      mobile: mobile ?? orElse,
      tablet: tablet ?? orElse,
      desktop: desktop ?? orElse,
    );
  }

  T resolve(BuildContext context) {
    switch (context.screenType) {
      case ScreenType.mobile:
        return mobile;
      case ScreenType.tablet:
        return tablet;
      case ScreenType.desktop:
        return desktop;
    }
  }
}

class ResponsiveBuilder extends StatelessWidget {
  final ResponsiveWidgetBuilder? builder;
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveBuilder._({
    Key? key,
    this.builder,
    this.mobile,
    this.tablet,
    this.desktop,
  })  : assert(builder != null
            ? true
            : (mobile != null || tablet != null || desktop != null)),
        super(key: key);

  factory ResponsiveBuilder({
    Key? key,
    required Widget mobile,
    required Widget tablet,
    Widget? desktop,
  }) {
    return ResponsiveBuilder._(
      key: key,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  factory ResponsiveBuilder.custom(
      {Key? key, required ResponsiveWidgetBuilder builder}) {
    return ResponsiveBuilder._(key: key, builder: builder);
  }

  @override
  Widget build(BuildContext context) {
    final screenType = context.screenType;
    if (builder != null) {
      return builder!(context, screenType);
    }

    Widget? widget = Responsive<Widget?>.when(
          mobile: mobile,
          tablet: tablet,
          desktop: desktop,
        ).resolve(context) ??
        tablet;

    return widget ?? const SizedBox();
  }
}
