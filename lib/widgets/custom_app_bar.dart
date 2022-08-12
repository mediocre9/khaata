import 'package:flutter/material.dart';
import '../constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  late String title;
  late String? subTitle;
  final double? letterSpacing;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevationLevel;
  final double titleFontSize;
  final double? subtitleFontSize;
  final double? height;
  final String? fontFamily;
  final FontWeight? titleFontWeight;
  final FontWeight? subTitleFontWeight;
  final double? horizontalPadding;
  final double? verticalPadding;
  final bool? capitalize;

  CustomAppBar({
    Key? key,
    required this.title,
    required this.titleFontSize,
    this.height = 65,
    this.letterSpacing,
    this.subTitle,
    this.backgroundColor,
    this.foregroundColor,
    this.elevationLevel,
    this.subtitleFontSize,
    this.titleFontWeight = FontWeight.bold,
    this.subTitleFontWeight,
    this.fontFamily,
    this.horizontalPadding,
    this.verticalPadding,
    this.capitalize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kAppBarBackColor,
      toolbarHeight: height,
      elevation: elevationLevel ?? 1.1,
      foregroundColor: Colors.black,
      title: Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 10.0,
          vertical: verticalPadding ?? 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title = (capitalize ?? true) ? title.toUpperCase() : title,
              style: TextStyle(
                letterSpacing: letterSpacing ?? 0,
                fontSize: titleFontSize,
                fontFamily: fontFamily ?? "Roboto",
                fontWeight: titleFontWeight,
              ),
            ),
            Text(
              subTitle =
                  ((capitalize ?? true) ? subTitle?.toUpperCase() : subTitle) ??
                      "",
              style: TextStyle(
                letterSpacing: letterSpacing ?? 0,
                fontWeight: subTitleFontWeight ?? FontWeight.normal,
                fontSize: subtitleFontSize ?? 18.0,
                fontFamily: fontFamily ?? "Roboto",
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height!);
}
