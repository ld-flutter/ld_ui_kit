part of ld_ui_kit;

class SelectedField<T> extends StatefulWidget {
  const SelectedField._({
    super.key,
    required SelectedFieldDelegate<T> delegate,
    T? selectedItem,
    OnItemSelectedCallback<T>? onSelected,
  })  : _delegate = delegate,
        _onSelected = onSelected;

  final SelectedFieldDelegate<T> _delegate;
  final OnItemSelectedCallback<T>? _onSelected;

  factory SelectedField({
    required String title,
    required List<T> items,
    required ItemLabelParser<T> labelParser,
    ItemLabelParser<T>? subtitleParser,
    Widget? leading,
    Widget? trailing,
    required T? selectedItem,
    OnItemSelectedCallback<T>? onSelected,
    OnFilterTextChanged<T>? onFilterTextChanged,
  }) {
    return SelectedField._(
      delegate: SelectedFieldSimpleDelegate<T>(
        title: title,
        items: items,
        labelParser: labelParser,
        subtitleParser: subtitleParser,
        leading: leading,
        trailing: trailing,
        selectedItem: selectedItem,
        onFilterTextChanged: onFilterTextChanged,
      ),
      onSelected: onSelected,
    );
  }

  factory SelectedField.custom({
    required String title,
    required List<T> items,
    required WidgetItemBuilder<T> itemBuilder,
    required ItemLabelParser<T> labelParser,
    required T? selectedItem,
    OnItemSelectedCallback<T>? onSelected,
    OnFilterTextChanged<T>? onFilterTextChanged,
  }) {
    return SelectedField._(
      delegate: SelectedFieldBuilderDelegate<T>(
        title: title,
        items: items,
        itemBuilder: itemBuilder,
        labelParser: labelParser,
        selectedItem: selectedItem,
        onFilterTextChanged: onFilterTextChanged,
      ),
      onSelected: onSelected,
    );
  }

  @override
  State<SelectedField<T>> createState() => _SelectedFieldState<T>();
}

class _SelectedFieldState<T> extends State<SelectedField<T>> {
  late final _tecSelectedItem = TextEditingController();

  @override
  void initState() {
    _tecSelectedItem.text = _selectedItemValue;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SelectedField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget._delegate.selectedItem != widget._delegate.selectedItem) {
      _tecSelectedItem.text = _selectedItemValue;
    }
  }

  @override
  void dispose() {
    _tecSelectedItem.dispose();
    super.dispose();
  }

  String get _selectedItemValue {
    return widget._delegate.selectedItem != null
        ? widget._delegate.labelParser(widget._delegate.selectedItem as T)
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: _tecSelectedItem,
      enabled: widget._delegate.items.isNotEmpty,
      decoration: InputDecoration(
        labelText: widget._delegate.title,
        suffixIcon: const Icon(Icons.arrow_drop_down_rounded),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        if (widget._delegate.items.isNotEmpty) {
          showSelectedBottomSheet<T>(
            context,
            widget._delegate,
            onSelected: widget._onSelected,
          );
        }
      },
    );
  }
}
