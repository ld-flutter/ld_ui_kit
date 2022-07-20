import 'package:flutter/material.dart';

import 'core.dart';

EdgeInsets getDefaultPadding(BuildContext context) => EdgeInsets.all(
      Responsive.when(
        mobile: 8.0,
        tablet: 16.0,
        desktop: 32.0,
      ).resolve(context),
    );

/// Radius
const kDefaultRadius = Radius.circular(28.0);
const kRadius16 = Radius.circular(16.0);

/// Border radius
const kDefaultBorderRadius = BorderRadius.all(kDefaultRadius);
const kBorderRadius16 = BorderRadius.all(kRadius16);

/// Border shape
const kDefaultBorderShape =
    RoundedRectangleBorder(borderRadius: kDefaultBorderRadius);
const kRoundedBorderShape16 =
    RoundedRectangleBorder(borderRadius: kBorderRadius16);
