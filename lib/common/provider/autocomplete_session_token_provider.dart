import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'autocomplete_session_token_provider.g.dart';

@Riverpod(keepAlive: true)
String autocompleteSessionToken(Ref ref) {
  return const Uuid().v4();
}
