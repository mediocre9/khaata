import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  late String title;
  late String? subTitle;
  final double? elevationLevel;
  final double? height;

  CustomAppBar({
    Key? key,
    required this.title,
    this.height = 65,
    this.subTitle,
    this.elevationLevel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevationLevel,
      toolbarHeight: height ?? Theme.of(context).appBarTheme.toolbarHeight,
      title: Container(
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title.toUpperCase()),
            Text(
              subTitle?.toUpperCase() ?? "subtitle here",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16.0,
                fontFamily: Theme.of(context).appBarTheme.toolbarTextStyle!.fontFamily,
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
