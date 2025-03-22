part of '../home_screen.dart';

class _DatePicker extends ConsumerWidget {
  const _DatePicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(_dateProvider);
    final materialLocalizations = MaterialLocalizations.of(context);

    final String text;
    if (date == null) {
      text = '';
    } else {
      text =
          '${materialLocalizations.formatMediumDate(date)} ${materialLocalizations.formatYear(date)}';
    }

    return TextFieldButton(
      text: text,
      hintText: 'Date',
      onTap: () async {
        final res = await showDatePicker(
          context: context,
          helpText: 'Select pick-up date',
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(AppConstants.maxFutureDateDif),
        );

        if (res != null) {
          ref.read(_dateProvider.notifier).newDate(res);
        }
      },
      borderRadius: const BorderRadius.horizontal(
        left: TextFieldButton.defaultRadius,
        right: Radius.circular(4),
      ),
    );
  }
}
