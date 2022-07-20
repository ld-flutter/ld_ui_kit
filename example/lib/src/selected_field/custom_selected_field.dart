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
    final colorScheme = context.getColorScheme();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SelectedField<String>.custom(
        title: widget.title,
        items: List.generate(20, (index) => 'Item $index'),
        selectedItem: _selectedItem,
        labelParser: (item) => item,
        onSelected: (item) => setState(() => _selectedItem = item),
        showFilterField: true,
        onFilterTextChanged: (item, query) => item.deepContains(query),
        itemBuilder: (BuildContext context, String item) {
          return Row(
            children: [
              const Icon(Icons.person_pin),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item),
                    Text(
                      'Description $item',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Checkbox(
                checkColor: colorScheme.primary,
                activeColor: colorScheme.onPrimary,
                value: _selectedItem == item,
                onChanged: (value) {},
              ),
            ],
          );
        },
      ),
    );
  }
}
