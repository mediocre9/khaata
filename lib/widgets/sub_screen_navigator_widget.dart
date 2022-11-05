import 'package:flutter/material.dart';

class SubScreenNavigatorButton extends StatelessWidget {
  final String label;
  final String route;
  const SubScreenNavigatorButton({
    Key? key,
    required this.label,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          label: Text(label),
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushReplacementNamed(context, route);
          },
        )
      ],
    );
  }
}
