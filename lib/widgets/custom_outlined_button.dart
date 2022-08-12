import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Color? borderColor;
  final Color? splashColor;
  final Color? backgroundColor;
  final Color? textColor;
  final String text;
  final double? borderWidth;
  final OutlinedBorder? buttonShape;
  final void Function() onPressed;

  const CustomOutlinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.splashColor,
    this.borderColor,
    this.backgroundColor,
    this.borderWidth,
    this.buttonShape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        primary: splashColor ?? Colors.lightBlueAccent,
        backgroundColor: backgroundColor ?? Colors.transparent,
        side: BorderSide(
            color: borderColor ?? const Color.fromRGBO(222, 231, 255, 1.0),
            width: borderWidth ?? 1.2),
        shape: buttonShape ?? const BeveledRectangleBorder(),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
            color: textColor ?? Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
