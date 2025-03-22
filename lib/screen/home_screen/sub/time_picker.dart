part of '../home_screen.dart';

class _TimePicker extends ConsumerWidget {
  const _TimePicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final time = ref.watch(_timeProvider);

    final String text;
    if (time == null) {
      text = '';
    } else {
      text = time.format(context);
    }

    return TextFieldButton(
      text: text,
      hintText: localizations.time,
      onTap: () async {
        final res = await showTimePicker(
          context: context,
          helpText: localizations.selectPickUpTime,
          initialTime: time ?? TimeOfDay.now(),
        );

        if (res != null) {
          ref.read(_timeProvider.notifier).newTime(res);
        }
      },
      borderRadius: const BorderRadius.horizontal(
        left: Radius.circular(4),
        right: TextFieldButton.defaultRadius,
      ),
    );
  }
}
