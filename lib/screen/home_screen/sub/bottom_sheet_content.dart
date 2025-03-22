part of '../home_screen.dart';

class _BottomSheetContent extends StatelessWidget {
  const _BottomSheetContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const padding = 16.0;
    const gap = Gap(padding);
    // to fix padding before and after passengers field
    const gap12 = Gap(12);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          gap,
          TextFieldButton(
            text: 'Pick-up',
            onTap: () async {
              final res = await ChooseLocationScreen.show(
                context,
                title: 'Pick-up location',
              );

              print(res);
            },
          ),
          gap,
          TextFieldButton(
            text: 'Drop-off',
            onTap: () async {
              final res = await ChooseLocationScreen.show(
                context,
                title: 'Drop-off location',
              );

              print(res);
            },
          ),
          gap12,
          Row(
            children: [
              Expanded(
                child: TextFieldButton(text: 'Passengers', onTap: () {}),
              ),
              const Gap(4),
              Card(
                color: theme.colorScheme.surfaceContainer,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton.filledTonal(
                        onPressed: () {},
                        icon: const Icon(Icons.remove),
                      ),
                      const SizedBox(
                        height: kMinInteractiveDimension / 2,
                        child: VerticalDivider(),
                      ),
                      IconButton.filledTonal(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          gap12,
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextFieldButton(
                  text: 'Date',
                  onTap: () async {
                    final res = await showDatePicker(
                      context: context,
                      helpText: 'Select pick-up date',
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        AppConstants.maxFutureDateDif,
                      ),
                    );

                    print(res);
                  },
                  borderRadius: const BorderRadius.horizontal(
                    left: TextFieldButton.defaultRadius,
                    right: Radius.circular(4),
                  ),
                ),
              ),
              const Gap(4),
              Expanded(
                flex: 2,
                child: TextFieldButton(
                  text: 'Time',
                  onTap: () async {
                    final res = await showTimePicker(
                      context: context,
                      helpText: 'Select pick-up time',
                      initialTime: TimeOfDay.now(),
                    );

                    print(res);
                  },
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(4),
                    right: TextFieldButton.defaultRadius,
                  ),
                ),
              ),
            ],
          ),
          gap,
          FilledButton(onPressed: () {}, child: const Text('Process')),
          gap,
          const BottomGap(),
        ],
      ),
    );
  }
}
