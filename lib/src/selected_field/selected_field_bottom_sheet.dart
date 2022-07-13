import 'package:flutter/material.dart';

import 'selected_field_delegate.dart';

Future<void> showSelectedBottomSheet<T>(
  BuildContext context,
  SelectedFieldDelegate<T> delegate,
) async {
  showModalBottomSheet(
    context: context,
    builder: (_) => SelectedBottomSheet(delegate: delegate),
  );
}

class SelectedBottomSheet<T> extends StatelessWidget {
  const SelectedBottomSheet({super.key, required this.delegate});

  final SelectedFieldDelegate<T> delegate;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
    );
  }
}
