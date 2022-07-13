import 'package:flutter/material.dart';
import 'package:ld_ui_kit/ld_ui_kit.dart';

typedef ResponsiveWidgetBuilder = Widget Function(
    BuildContext context, ScreenType screenType);

enum ScreenType {
  mobile(400),
  tablet(600),
  desktop(800);

  final double maxWidth;

  const ScreenType(this.maxWidth);
}

extension ResponsiveX on BuildContext {
  ScreenType get screenType {
    final w = orientation == Orientation.portrait
        ? screenSize.width
        : screenSize.height;
    return ScreenType.values.firstWhere(
      (type) => w <= type.maxWidth,
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
  const ResponsiveBuilder({
    super.key,
    this.builder,
    this.mobile,
    this.tablet,
    this.desktop,
  }) : assert(builder != null ||
            mobile != null ||
            tablet != null ||
            desktop != null);

  final ResponsiveWidgetBuilder? builder;
  final WidgetBuilder? mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder? desktop;

  @override
  Widget build(BuildContext context) {
    final screenType = context.screenType;
    if (builder != null) {
      return builder!(context, screenType);
    }

    WidgetBuilder? widget = Responsive<WidgetBuilder?>.when(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    ).resolve(context);

    return widget?.call(context) ??
        mobile?.call(context) ??
        tablet?.call(context) ??
        desktop?.call(context) ??
        const SizedBox();
  }
}
