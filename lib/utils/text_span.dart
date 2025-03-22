import 'package:flutter/painting.dart';

TextSpan buildHighlightedTextSpan(
  String text,
  List<({int length, int offset})> highlights,
) {
  final highlightsSorted =
      highlights.toList()..sort((a, b) => a.offset.compareTo(b.offset));

  int currentIndex = 0;
  List<TextSpan> spans = [];

  for (final highlight in highlightsSorted) {
    if (highlight.offset > currentIndex) {
      spans.add(TextSpan(text: text.substring(currentIndex, highlight.offset)));
    }
    spans.add(
      TextSpan(
        text: text.substring(
          highlight.offset,
          highlight.offset + highlight.length,
        ),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
    currentIndex = highlight.offset + highlight.length;
  }

  if (currentIndex < text.length) {
    spans.add(TextSpan(text: text.substring(currentIndex)));
  }

  return TextSpan(children: spans);
}
