part of '../choose_location_screen.dart';

@riverpod
Future<List<AutocompleteItem>> _autocompleteByTerm(Ref ref, String term) async {
  final locationAutocomplete = ref.watch(
    locationAutocompleteRepositoryProvider,
  );
  final sessionToken = ref.watch(_sessionTokenProvider);

  final termTrimmed = term.trim();

  if (termTrimmed.isEmpty) {
    return const [];
  }

  await ref.debounce();

  final results = await locationAutocomplete.autocomplete(
    input: term,
    language: 'en',
    sessionToken: sessionToken,
  );

  return results.asFuture;
}
