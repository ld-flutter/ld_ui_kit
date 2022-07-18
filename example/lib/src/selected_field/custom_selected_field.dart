import 'package:flutter/material.dart';
import 'package:ld_ui_kit/ld_ui_kit.dart';

class CustomSelectedField extends StatefulWidget {
  const CustomSelectedField({super.key, required this.title});

  final String title;

  @override
  State<CustomSelectedField> createState() => _CustomSelectedFieldState();
}

class _CustomSelectedFieldState extends State<CustomSelectedField> {
  String _selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SelectedField<String>.custom(
        title: widget.title,
        items: List.generate(10, (index) => 'Item $index'),
        selectedItem: _selectedItem,
        labelParser: (item) => item,
        onSelected: (item) => setState(() => _selectedItem = item),
        itemBuilder: (BuildContext context, String item) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item),
              Text(
                'Description $item',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          );
        },
      ),
    );
  }
}
