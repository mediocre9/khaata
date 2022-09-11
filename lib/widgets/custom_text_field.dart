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
    this.isDense,
    this.hintText,
    this.maxLength,
    this.focusNode,
  })  : assert(contentPadding != null),
        super(key: key);

  final String? hintText;
  final Color? fillColor;
  final Color? color;
  final double? contentPadding;
  final bool? isDense;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final int? maxLength;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: color),
      onChanged: onChanged,
      focusNode: focusNode,
      keyboardType: inputType ?? TextInputType.text,
      controller: controller,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hintText,
        isDense: isDense,
        fillColor: fillColor,
        contentPadding: EdgeInsets.all(contentPadding!),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 3,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 3,
          ),
        ),
      ),
    );
  }
}
