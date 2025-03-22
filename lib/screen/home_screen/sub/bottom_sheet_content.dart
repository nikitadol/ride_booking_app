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
