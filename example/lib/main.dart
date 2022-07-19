import 'package:example/src/selected_field/custom_selected_field.dart';
import 'package:example/src/selected_field/simple_selected_field.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Kit Example',
      theme: ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SimpleSelectedField(title: 'Simple'),
              SimpleSelectedField(
                title: 'Simple with subtitle',
                showSubtitle: true,
              ),
              SimpleSelectedField(
                icon: Icon(Icons.ac_unit),
                title: 'Simple with subtitle, icons',
                showSubtitle: true,
              ),
              CustomSelectedField(title: 'Custom'),
            ],
          ),
        ),
      ),
    );
  }
}

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      appInfo: AppInfo(name: 'UI Kit Example'),
      themes: [
        WidgetbookTheme(
          name: 'Light',
          data: ThemeData(
            brightness: Brightness.light,
            colorSchemeSeed: Colors.blue,
            useMaterial3: true,
          ),
        ),
        WidgetbookTheme(
          name: 'Dark',
          data: ThemeData(
            brightness: Brightness.dark,
            colorSchemeSeed: Colors.amber,
            useMaterial3: true,
          ),
        ),
      ],
      categories: [
        WidgetbookCategory(
          name: 'Fields',
          widgets: [
            WidgetbookComponent(
              name: 'Selected Field',
              useCases: [
                WidgetbookUseCase(
                  name: 'Simple',
                  builder: (context) =>
                      const SimpleSelectedField(title: 'Simple item layout'),
                ),
                WidgetbookUseCase(
                  name: 'Custom item layout',
                  builder: (context) => CustomSelectedField(
                    title: context.knobs.text(
                      label: 'Title',
                      initialValue: 'Item',
                      description: 'Field/BottomSheet title',
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
