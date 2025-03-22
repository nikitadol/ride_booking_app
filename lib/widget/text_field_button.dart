import 'package:flutter/material.dart';

class TextFieldButton extends StatelessWidget {
  const TextFieldButton({
    super.key,
    required this.text,
    this.controller,
    this.onTap,
    this.borderRadius,
    this.suffixIcon,
  });

  static const defaultRadius = Radius.circular(16);

  final TextEditingController? controller;
  final GestureTapCallback? onTap;
  final String text;
  final BorderRadius? borderRadius;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      canRequestFocus: false,
      controller: controller,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: text,
        filled: true,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: borderRadius ?? const BorderRadius.all(defaultRadius),
        ),
      ),
    );
  }
}
