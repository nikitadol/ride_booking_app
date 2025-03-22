import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarDimmer extends StatelessWidget {
  const StatusBarDimmer._({super.key, required this.size});

  final Size size;

  static PreferredSizeWidget from(BuildContext context, {Key? key}) {
    final padding = MediaQuery.paddingOf(context);
    final systemBarSize = Size(double.infinity, padding.top);

    return PreferredSize(
      preferredSize: systemBarSize,
      child: StatusBarDimmer._(key: key, size: systemBarSize),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.scaffoldBackgroundColor;

    return AnnotatedRegion(
      value: switch (theme.brightness) {
        Brightness.dark => SystemUiOverlayStyle.light,
        Brightness.light => SystemUiOverlayStyle.dark,
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.5),
              color.withValues(alpha: 0.1),
              color.withValues(alpha: 0),
            ],
            stops: const [0, 0.8, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SizedBox.fromSize(size: size),
      ),
    );
  }
}
