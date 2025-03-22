import 'package:flutter/material.dart';

class TextFieldButton extends StatefulWidget {
  const TextFieldButton({
    super.key,
    required this.hintText,
    required this.text,
    this.onTap,
    this.borderRadius,
    this.suffixIcon,
  });

  static const defaultRadius = Radius.circular(16);

  final GestureTapCallback? onTap;
  final String hintText;
  final String text;
  final BorderRadius? borderRadius;
  final Widget? suffixIcon;

  @override
  State<TextFieldButton> createState() => _TextFieldButtonState();
}

class _TextFieldButtonState extends State<TextFieldButton> {
  late final _controller = TextEditingController(text: widget.text);

  @override
  void didUpdateWidget(covariant TextFieldButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    _controller.text = widget.text;
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      canRequestFocus: false,
      enableInteractiveSelection: false,
      controller: _controller,
      maxLines: 2,
      minLines: 1,
      onTap: widget.onTap,
      decoration: InputDecoration(
        labelText: widget.hintText,
        filled: true,
        suffixIcon: widget.suffixIcon,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius:
              widget.borderRadius ??
              const BorderRadius.all(TextFieldButton.defaultRadius),
        ),
      ),
    );
  }
}
