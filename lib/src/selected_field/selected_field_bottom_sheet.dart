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
      maxHeight: context.screenSize.height * .6,
    ),
    builder: (_) => SelectedBottomSheet(
      delegate: delegate,
      onSelected: onSelected,
    ),
  );
}

class SelectedBottomSheet<T> extends StatelessWidget {
  const SelectedBottomSheet({
    super.key,
    required this.delegate,
    this.onSelected,
  });

  final SelectedFieldDelegate<T> delegate;
  final OnItemSelectedCallback<T>? onSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: kDefaultBorderShape,
      color: context.colorScheme.surface,
      margin: getDefaultPadding(context),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                ),
                Text(
                  'Select ${delegate.title}',
                  style: context.textTheme.titleLarge,
                ),
              ],
            ),
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                radius: kDefaultRadius,
                thickness: 2,
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: delegate.items.length,
                  itemBuilder: (context, index) {
                    final item = delegate.items[index];
                    final isSelected = item == delegate.selectedItem;
                    return InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        onSelected?.call(item);
                      },
                      borderRadius: kDefaultBorderRadius,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? context.colorScheme.primary
                              : Colors.transparent,
                          borderRadius: kDefaultBorderRadius,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: DefaultTextStyle(
                            style: TextStyle(
                              color: isSelected
                                  ? context.colorScheme.onPrimary
                                  : context.colorScheme.onSurface,
                            ),
                            child: delegate.itemBuilder(context, item),
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
    );
  }
}
