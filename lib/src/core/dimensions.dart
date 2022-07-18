import 'package:flutter/material.dart';

import 'core.dart';

EdgeInsets getDefaultPadding(BuildContext context) => EdgeInsets.all(
      Responsive.when(
        mobile: 8.0,
        tablet: 16.0,
        desktop: 32.0,
      ).resolve(context),
    );

const kDefaultRadiusValue = 28.0;
const kDefaultRadius = Radius.circular(kDefaultRadiusValue);
const kDefaultBorderRadius = BorderRadius.all(kDefaultRadius);
const kDefaultBorderShape =
    RoundedRectangleBorder(borderRadius: kDefaultBorderRadius);
