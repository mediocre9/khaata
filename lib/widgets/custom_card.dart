import 'package:flutter/material.dart';
import 'package:khata/constants.dart';

class CustomCard extends StatelessWidget {
  final bool? shadow;
  final Widget? child;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? elevationLevel;
  final double? verticalMargin;
  final double? horizontalMargin;
  final MainAxisAlignment? innerMainAlignment;
  final CrossAxisAlignment? innerCrossAlignment;

  const CustomCard({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.shadow = true,
    this.borderRadius,
    this.elevationLevel,
    this.verticalMargin,
    this.horizontalMargin,
    this.innerMainAlignment,
    this.innerCrossAlignment,
  }) : super(key: key);

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      boxShadow: [
        shadow!
            ? const BoxShadow(
                spreadRadius: 2,
                blurRadius: 12,
                offset: Offset(2, 2),
                color: Colors.black,
                blurStyle: BlurStyle.normal,
              )
            : const BoxShadow(),
      ],
      borderRadius: BorderRadius.circular(
        borderRadius ?? 10,
      ),
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
          borderRadius: BorderRadius.circular(
            borderRadius ?? 10,
          ),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: horizontalMargin ?? 10,
          vertical: verticalMargin ?? 10,
        ),
        child: Container(
          decoration: _cardDecoration(),
          child: child,
        ),
      ),
    );
  }
}
