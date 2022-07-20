part of ld_ui_kit;

enum ButtonState { idle, loading, success, error }

enum ButtonShape { pill, rounded, sharp }

class ProgressButton extends StatefulWidget {
  const ProgressButton({
    super.key,
    required this.state,
    required this.onPressed,
    required this.child,
    this.shape = ButtonShape.pill,
  });

  /// Button state
  final ButtonState state;

  /// Button shape
  final ButtonShape shape;

  final Widget child;
  final VoidCallback? onPressed;

  @override
  State<ProgressButton> createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
    with SingleTickerProviderStateMixin {
  late ButtonState _state = widget.state;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  @override
  void didUpdateWidget(covariant ProgressButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _state = widget.state;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  OutlinedBorder? get _buttonShape {
    switch (widget.shape) {
      case ButtonShape.pill:
        return kDefaultBorderShape;
      case ButtonShape.rounded:
        return kRoundedBorderShape16;
      case ButtonShape.sharp:
        return const RoundedRectangleBorder();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (_state == ButtonState.loading) {
      child = const CircularProgressIndicator();
    } else {
      child = ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: _buttonShape,
        ),
        onPressed: widget.onPressed,
        child: widget.child,
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: child,
    );
  }
}
