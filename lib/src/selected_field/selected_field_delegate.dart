import 'package:flutter/material.dart';

import 'selected_field_typedefs.dart';

@protected
abstract class SelectedFieldDelegate<T> {
  final String title;
  final WidgetItemBuilder<T> itemBuilder;
  final OnItemSelectedCallback<T>? onSelected;

  SelectedFieldDelegate({
    required this.title,
    required this.itemBuilder,
    this.onSelected,
  });
}

@protected
class SelectedFieldBuilderDelegate<T> extends SelectedFieldDelegate<T> {
  SelectedFieldBuilderDelegate({
    required super.title,
    required super.itemBuilder,
    super.onSelected,
  });
}

@protected
class SelectedFieldSimpleDelegate<T> extends SelectedFieldDelegate<T> {
  SelectedFieldSimpleDelegate({
    required super.title,
    required ItemLabelParser<T> labelParser,
    super.onSelected,
  }) : super(
          itemBuilder: (BuildContext context, T item) {
            return ListTile(
              onTap: () {},
              title: Text(labelParser(item)),
            );
          },
        );
}
