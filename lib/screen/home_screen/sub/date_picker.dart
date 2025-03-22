part of '../home_screen.dart';

class _DatePicker extends ConsumerWidget {
  const _DatePicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final date = ref.watch(dateProvider);
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
      hintText: localizations.date,
      onTap: () async {
        final res = await showDatePicker(
          context: context,
          helpText: localizations.selectPickUpDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(AppConstants.maxFutureDateDif),
        );

        if (res != null) {
          ref.read(dateProvider.notifier).newDate(res);
        }
      },
      borderRadius: const BorderRadius.horizontal(
        left: TextFieldButton.defaultRadius,
        right: Radius.circular(4),
      ),
    );
  }
}
