import 'package:flutter/material.dart';
import 'package:ld_ui_kit/ld_ui_kit.dart';

class ProgressButtonWidget extends StatefulWidget {
  const ProgressButtonWidget({super.key});

  @override
  State<ProgressButtonWidget> createState() => _ProgressButtonWidgetState();
}

class _ProgressButtonWidgetState extends State<ProgressButtonWidget> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return ProgressButton(
      state: _loading ? ButtonState.loading : ButtonState.idle,
      onPressed: () async {
        setState(() => _loading = true);
        await Future.delayed(const Duration(seconds: 3));
        setState(() => _loading = false);
      },
      child: const Text('Progress Button'),
    );
  }
}
