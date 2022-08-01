part of ld_ui_kit;

Future<void> showSelectedBottomSheet<T>(
  BuildContext context,
  SelectedFieldDelegate<T> delegate, {
  OnItemSelectedCallback<T>? onSelected,
}) async {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight: context.getScreenSize().height * .8,
    ),
    builder: (_) => SelectedBottomSheet(
      delegate: delegate,
      onSelected: onSelected,
    ),
  );
}

class SelectedBottomSheet<T> extends StatefulWidget {
  const SelectedBottomSheet({
    super.key,
    required this.delegate,
    this.onSelected,
  });

  final SelectedFieldDelegate<T> delegate;
  final OnItemSelectedCallback<T>? onSelected;

  @override
  State<SelectedBottomSheet<T>> createState() => _SelectedBottomSheetState<T>();
}

class _SelectedBottomSheetState<T> extends State<SelectedBottomSheet<T>> {
  String _filterText = '';

  @override
  Widget build(BuildContext context) {
    final currentItems = widget.delegate.filterData(_filterText);
    final colorScheme = context.getColorScheme();
    final textTheme = context.getTextTheme();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Card(
        shape: kDefaultBorderShape,
        color: colorScheme.surface,
        margin: getDefaultPadding(context) +
            EdgeInsets.only(bottom: context.getMediaQuery().viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  Expanded(
                    child: Text(
                      'Select ${widget.delegate.title}',
                      style: textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: widget.delegate.onFilterTextChanged != null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search_rounded),
                      labelText: 'Filter',
                    ),
                    onChanged: (text) => setState(() => _filterText = text),
                  ),
                ),
              ),
              Flexible(
                child: Scrollbar(
                  thumbVisibility: true,
                  radius: kDefaultRadius,
                  thickness: 2,
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: currentItems.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = currentItems[index];
                      final isSelected = item == widget.delegate.selectedItem;
                      return InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          widget.onSelected?.call(item);
                        },
                        borderRadius: kDefaultBorderRadius,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? colorScheme.primary
                                : Colors.transparent,
                            borderRadius: kDefaultBorderRadius,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: IconTheme(
                              data: IconThemeData(
                                color: isSelected
                                    ? colorScheme.onPrimary
                                    : colorScheme.onSurface,
                              ),
                              child: DefaultTextStyle(
                                style: TextStyle(
                                  color: isSelected
                                      ? colorScheme.onPrimary
                                      : colorScheme.onSurface,
                                ),
                                child:
                                    widget.delegate.itemBuilder(context, item),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
