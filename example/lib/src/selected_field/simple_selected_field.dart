import 'package:flutter/material.dart';
import 'package:ld_ui_kit/ld_ui_kit.dart';

class SimpleSelectedField extends StatefulWidget {
  const SimpleSelectedField({
    super.key,
    required this.title,
    this.showSubtitle = false,
    this.icon,
  });

  final String title;
  final bool showSubtitle;
  final Widget? icon;

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
        title: widget.title,
        items: List.generate(20, (index) => 'Item $index'),
        selectedItem: _selectedItem,
        labelParser: (item) => item,
        subtitleParser:
            widget.showSubtitle ? (item) => 'Description $item' : null,
        leading: widget.icon,
        trailing: widget.icon,
        onSelected: (item) => setState(() => _selectedItem = item),
      ),
    );
  }
}
