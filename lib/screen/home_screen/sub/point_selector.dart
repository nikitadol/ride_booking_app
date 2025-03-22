part of '../home_screen.dart';

class _PointSelector extends ConsumerWidget {
  const _PointSelector({required this.pointType});

  final PointType pointType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final point = ref.watch(pointProvider(pointType));

    final String hintText;
    final String selectorTitle;
    switch (pointType) {
      case PointType.pickUp:
        hintText = localizations.pickUp;
        selectorTitle = localizations.pickUpLocation;
      case PointType.dropOff:
        hintText = localizations.dropOff;
        selectorTitle = localizations.dropOffLocation;
    }

    return TextFieldButton(
      text: point?.name ?? '',
      hintText: hintText,
      onTap: () async {
        final res = await ChooseLocationScreen.show(
          context,
          title: selectorTitle,
        );
        if (res != null) {
          ref
              .read(pointProvider(pointType).notifier)
              .newLocation(res.id, res.name);
        }
      },
    );
  }
}
