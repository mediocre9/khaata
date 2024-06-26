import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:khata/constants.dart';

mixin NeumorphicDecoration {
  BoxDecoration neumorphic() {
    return const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      color: Color.fromARGB(255, 253, 253, 253),
      boxShadow: [
        BoxShadow(
          color: Colors.white,
          spreadRadius: 0.4,
          blurRadius: 1,
        ),
        BoxShadow(
          color: Color.fromARGB(255, 65, 65, 65),
          spreadRadius: 1.5,
          blurRadius: 4,
          offset: Offset(1, 4),
          inset: true,
        )
      ],
    );
  }
}

mixin GradientDecoration {
  BoxDecoration gradientDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(7),
      shape: BoxShape.rectangle,
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          kBlueGradient,
          kTealGradient,
        ],
      ),
    );
  }
}
