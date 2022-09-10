import 'package:flutter/material.dart';
import 'package:khata/themes/decorations.dart';

class NeumorphicContainer extends StatelessWidget with NeumorphicBoxDecoration {
  final Widget cubitStateManager;
  const NeumorphicContainer({
    Key? key,
    required this.cubitStateManager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: neumorphicDecoration(),
        child: cubitStateManager,
      ),
    );
  }
}
