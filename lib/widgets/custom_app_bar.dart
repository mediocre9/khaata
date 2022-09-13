import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Text title;
  final Text subtitle;
  final double? height;
  final double? elevationLevel;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.subtitle,
    this.height = 65,
    this.elevationLevel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevationLevel ?? Theme.of(context).appBarTheme.elevation,
      toolbarHeight: height ?? Theme.of(context).appBarTheme.toolbarHeight,
      title: Container(
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title.data!.toUpperCase()),
            Text(
              subtitle.data!.toUpperCase(),
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.normal,
                fontFamily:
                    Theme.of(context).appBarTheme.toolbarTextStyle?.fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height!);
}
