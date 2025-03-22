part of '../home_screen.dart';

class _BottomSheetContent extends StatelessWidget {
  const _BottomSheetContent();

  @override
  Widget build(BuildContext context) {
    const padding = 16.0;
    const gap = Gap(padding);
    // to fix padding before and after passengers field
    const gap12 = Gap(12);

    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          gap,

          _PointSelector(pointType: PointType.pickUp),
          gap,
          _PointSelector(pointType: PointType.dropOff),
          gap12,
          _PassengersPicker(),
          gap12,
          Row(
            children: [
              Expanded(flex: 3, child: _DatePicker()),
              Gap(4),
              Expanded(flex: 2, child: _TimePicker()),
            ],
          ),
          gap,
          _ProcessButton(),
          gap,
          BottomGap(),
        ],
      ),
    );
  }
}

class _PointSelector extends ConsumerWidget {
  const _PointSelector({required this.pointType});

  final PointType pointType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final point = ref.watch(_pointProvider(pointType));

    final String hintText;
    final String selectorTitle;
    switch (pointType) {
      case PointType.pickUp:
        hintText = 'Pick-up';
        selectorTitle = 'Pick-up location';
      case PointType.dropOff:
        hintText = 'Drop-off';
        selectorTitle = 'Drop-off location';
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
              .read(_pointProvider(pointType).notifier)
              .newLocation(res.id, res.name);
        }
      },
    );
  }
}
