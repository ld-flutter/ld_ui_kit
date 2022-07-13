import 'dart:async';

import 'package:flutter/material.dart';

@protected
typedef OnItemSelectedCallback<T> = FutureOr<void> Function(T item);

@protected
typedef WidgetItemBuilder<T> = Widget Function(BuildContext context, T item);

@protected
typedef ItemLabelParser<T> = String Function(T item);
