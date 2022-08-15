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
    this.maxLength,
    this.counterStyle,
  })  : assert(contentPadding != null),
        super(key: key);

  final String? hintText;
  final Color? fillColor;
  final Color? color;
  final Color? counterStyle;
  final double? contentPadding;
  final double? borderRadius;
  final bool? isDense;
  final bool? isFilled;
  final TextInputType? inputType;
  final InputBorder? borderStyle;
  final TextEditingController? controller;
  final int? maxLength;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      style: TextStyle(color: color),
      onChanged: onChanged,
      // autocorrect: true,
      // enableSuggestions: true,
      keyboardType: inputType ?? TextInputType.text,
      controller: controller,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hintText,
        isDense: isDense,
        filled: isFilled,
        fillColor: fillColor,
        counterStyle: TextStyle(color: counterStyle ?? Colors.black),
        contentPadding: EdgeInsets.all(contentPadding!),
        focusedBorder: borderStyle ?? const OutlineInputBorder(),
        enabledBorder: borderStyle ??
            OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(borderRadius ?? 2),
            ),
      ),
    );
  }
}
