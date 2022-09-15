import 'package:flutter/material.dart';
import 'package:comparison/app5/sizes.dart';

class CustomIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  double height;
  double width;
  final double iconSize;

  CustomIconButton({
    Key? key,
    required this.iconData,
    required this.onPressed,
    this.backgroundColor = Colors.transparent,
    this.iconColor = Colors.white,
    this.height = Sizes.mainPageRowActionsSize,
    this.width = Sizes.mainPageRowActionsSize,
    this.iconSize = Sizes.mainPageRowActionsSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (iconSize > height) {
      height = iconSize;
    }
    if (iconSize > width) {
      width = iconSize;
    }
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: backgroundColor,
        width: width,
        height: height,
        child: Icon(
          iconData,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}
