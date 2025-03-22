import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class BottomGap extends StatelessWidget {
  const BottomGap({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);

    return Gap(padding.bottom);
  }
}
