part of '../home_screen.dart';

class _TimePicker extends ConsumerWidget {
  const _TimePicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(_timeProvider);

    final String text;
    if (time == null) {
      text = '';
    } else {
      text = time.format(context);
    }

    return TextFieldButton(
      text: text,
      hintText: 'Time',
      onTap: () async {
        final res = await showTimePicker(
          context: context,
          helpText: 'Select pick-up time',
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
