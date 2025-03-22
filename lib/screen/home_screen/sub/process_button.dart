part of '../home_screen.dart';

class _ProcessButton extends ConsumerWidget {
  const _ProcessButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFormValid = ref.watch(_isFormValidProvider);

    return FilledButton(
      onPressed: isFormValid ? () {} : null,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Process', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
