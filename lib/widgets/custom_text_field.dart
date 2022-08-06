import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.contentPadding,
    this.color = Colors.black,
    this.inputType,
    this.fillColor,
    this.borderRadius,
    this.isDense,
    this.hintText,
    this.borderStyle,
    this.isFilled,
  })  : assert(contentPadding != null),
        super(key: key);

  final String? hintText;
  final Color? fillColor;
  final Color? color;
  final double? contentPadding;
  final double? borderRadius;
  final bool? isDense;
  final bool? isFilled;
  final TextInputType? inputType;
  final InputBorder? borderStyle;
  final TextEditingController? controller;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      style: TextStyle(color: color),
      onChanged: onChanged,
      autocorrect: true,
      enableSuggestions: true,
      keyboardType: inputType ?? TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        fillColor: fillColor,
        focusedBorder: borderStyle ?? const OutlineInputBorder(),
        hintText: hintText,
        isDense: isDense,
        filled: isFilled,
        contentPadding: EdgeInsets.all(contentPadding!),
        enabledBorder: borderStyle ??
            OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(borderRadius ?? 2),
            ),
      ),
    );
  }
}
