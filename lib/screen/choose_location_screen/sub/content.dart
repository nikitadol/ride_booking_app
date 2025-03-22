part of '../choose_location_screen.dart';

class _ChooseLocationScreenContent extends ConsumerWidget {
  const _ChooseLocationScreenContent({required this.term});

  final String term;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final padding = MediaQuery.paddingOf(context);
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final contentPadding =
        const EdgeInsets.symmetric(vertical: 8) + viewInsets + padding;

    final provider = _autocompleteByTermProvider(term);
    final results = ref.watch(provider);

    return results.when(
      error:
          (e, s) => Padding(
            padding: contentPadding,
            child: ErrorComponent(
              error: e,
              stackTrace: s,
              onRetry: () => ref.invalidate(provider),
            ),
          ),
      loading: () => const Center(child: CircularProgressIndicator()),
      data:
          (results) => ListView.separated(
            itemCount: results.length,
            padding: contentPadding,
            itemBuilder: (context, index) {
              final item = results[index];

              return ListTile(
                onTap:
                    () => Navigator.pop<ChooseLocationScreenResult>(context, (
                      id: item.id,
                      name: item.description,
                    )),
                title: Text.rich(
                  buildHighlightedTextSpan(
                    item.description,
                    item.matchedSubstrings,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          ),
    );
  }
}
