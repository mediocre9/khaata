import 'package:flutter/material.dart';
import 'package:khata/themes/decorations.dart';

abstract class InterfaceStateManager extends Widget {
  const InterfaceStateManager({super.key});
}

class TrayContainer extends StatelessWidget
    with NeumorphicDecoration
    implements InterfaceStateManager {
  final InterfaceStateManager stateManager;

  const TrayContainer({
    Key? key,
    required this.stateManager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: neumorphic(),
        child: stateManager,
      ),
    );
  }
}
