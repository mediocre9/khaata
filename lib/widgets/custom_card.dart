import 'package:flutter/material.dart';
import 'package:khata/constants.dart';

class CustomCard extends StatelessWidget {
  final double? borderRadius;
  final double? elevationLevel;
  final double? height;
  final double? width;
  final double? horizontalMargin;
  final double? verticalMargin;
  final Widget? child;
  final bool? shadow;
  final CrossAxisAlignment? innerCrossAlignment;
  final MainAxisAlignment? innerMainAlignment;

  const CustomCard({
    Key? key,
    this.height,
    this.width,
    this.shadow = true,
    this.elevationLevel,
    this.innerCrossAlignment,
    this.innerMainAlignment,
    required this.child,
    this.borderRadius,
    this.horizontalMargin,
    this.verticalMargin,
  }) : super(key: key);

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      boxShadow: [
        shadow!
            ? const BoxShadow(
                color: Colors.black,
                blurRadius: 12,
                blurStyle: BlurStyle.normal,
                spreadRadius: 2,
                offset: Offset(2, 2),
              )
            : const BoxShadow(),
      ],
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Card(
        elevation: elevationLevel ?? 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin ?? 10, vertical: verticalMargin ?? 10),
        child: Container(
          decoration: _cardDecoration(),
          child: child,
        ),
      ),
    );
  }
}
