import 'package:flutter/material.dart';
import 'package:khata/constants.dart';

class AppTextFieldLabel extends StatelessWidget {
  final String data;
  const AppTextFieldLabel({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          data.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            letterSpacing: 1.1,
            fontWeight: FontWeight.bold,
            color: kTextColor,
          ),
        ),
        const Icon(Icons.search_rounded, size: 14)
      ],
    );
  }
}