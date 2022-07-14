import 'package:flutter/material.dart';

import 'selected_field_typedefs.dart';

@protected
abstract class SelectedFieldDelegate<T> {
  final String title;
  final List<T> items;
  final WidgetItemBuilder<T> itemBuilder;
  final ItemLabelParser<T> labelParser;
  final T? selectedItem;

  SelectedFieldDelegate({
    required this.title,
    required this.items,
    required this.itemBuilder,
    required this.labelParser,
    this.selectedItem,
  });
}

@protected
class SelectedFieldBuilderDelegate<T> extends SelectedFieldDelegate<T> {
  SelectedFieldBuilderDelegate({
    required super.title,
    required super.items,
    required super.itemBuilder,
    required super.labelParser,
    super.selectedItem,
  });
}

@protected
class SelectedFieldSimpleDelegate<T> extends SelectedFieldDelegate<T> {
  SelectedFieldSimpleDelegate({
    required super.title,
    required super.items,
    required super.labelParser,
    super.selectedItem,
  }) : super(
          itemBuilder: (BuildContext context, T item) {
            return Text(labelParser(item));
          },
        );
}
