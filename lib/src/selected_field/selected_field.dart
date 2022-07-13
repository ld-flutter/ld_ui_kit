part of ld_ui_kit;

class SelectedField<T> extends StatelessWidget {
  const SelectedField._({
    super.key,
    required SelectedFieldDelegate<T> delegate,
  }) : _delegate = delegate;

  final SelectedFieldDelegate<T> _delegate;

  factory SelectedField({
    required String title,
    required ItemLabelParser<T> labelParser,
  }) {
    return SelectedField._(
      delegate: SelectedFieldSimpleDelegate<T>(
        title: title,
        labelParser: labelParser,
      ),
    );
  }

  factory SelectedField.builder({
    required String title,
    required WidgetItemBuilder<T> itemBuilder,
  }) {
    return SelectedField._(
      delegate: SelectedFieldBuilderDelegate<T>(
        title: title,
        itemBuilder: itemBuilder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: _delegate.title,
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        showSelectedBottomSheet(context, _delegate);
      },
    );
  }
}
