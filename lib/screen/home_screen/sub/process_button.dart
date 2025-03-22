part of '../home_screen.dart';

class _ProcessButton extends ConsumerWidget {
  const _ProcessButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final isFormValid = ref.watch(_isFormValidProvider);

    return FilledButton(
      onPressed: isFormValid ? () {} : null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          localizations.process,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
