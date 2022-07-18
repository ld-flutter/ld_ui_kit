import 'package:flutter/material.dart';
import 'package:ld_ui_kit/ld_ui_kit.dart';

class SimpleSelectedField extends StatefulWidget {
  const SimpleSelectedField({super.key});

  @override
  State<SimpleSelectedField> createState() => _SimpleSelectedFieldState();
}

class _SimpleSelectedFieldState extends State<SimpleSelectedField> {
  String _selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SelectedField<String>(
        title: 'item'.capitalize(),
        items: List.generate(10, (index) => 'Item $index'),
        selectedItem: _selectedItem,
        labelParser: (item) => item,
        onSelected: (item) => setState(() => _selectedItem = item),
      ),
    );
  }
}
