part of '../home_screen.dart';

class _PassengersPicker extends ConsumerWidget {
  const _PassengersPicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final passengers = ref.watch(_passengersProvider);

    return Row(
      children: [
        Expanded(
          child: TextFieldButton(
            text: passengers?.toString() ?? '',
            hintText: localizations.passengers,
          ),
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
                IconButton(
                  onPressed:
                      () => ref.read(_passengersProvider.notifier).decrease(),
                  icon: const Icon(Icons.remove),
                ),
                const SizedBox(
                  height: kMinInteractiveDimension / 2,
                  child: VerticalDivider(),
                ),
                IconButton(
                  onPressed:
                      () => ref.read(_passengersProvider.notifier).increase(),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
