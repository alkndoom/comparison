import 'package:flutter/material.dart';
import 'package:comparison/app5_spotify_clone/sizes.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final double height;
  final List<CustomBottomNavigationBarItem> items;

  const CustomBottomNavigationBar({
    Key? key,
    this.height = Sizes.bottomNavigationBarHeight,
    required this.items,
  }) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [0, 1],
          colors: [Colors.black, Colors.black26],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widget.items,
          ),
        ],
      ),
    );
  }
}

class CustomBottomNavigationBarItem extends StatefulWidget {
  final String? label;
  final IconData iconData;
  final VoidCallback onPressed;
  final double iconSize;
  final Color iconColor;
  final double labelSize;
  final Color labelColor;
  final Color backgroundColor;

  const CustomBottomNavigationBarItem({
    Key? key,
    required this.iconData,
    required this.onPressed,
    this.label,
    this.iconSize = Sizes.bottomNavigationBarItemIconSize,
    this.iconColor = const Color(0xFF626666),
    this.labelSize = Sizes.bottomNavigationBarItemLabelSize,
    this.labelColor = const Color(0xFF626666),
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  @override
  State<CustomBottomNavigationBarItem> createState() => _CustomBottomNavigationBarItemState();
}

class _CustomBottomNavigationBarItemState extends State<CustomBottomNavigationBarItem> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          color: widget.backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.iconData,
                size: widget.iconSize,
                color: widget.iconColor,
              ),
              widget.label != null
                  ? Text(
                      widget.label!,
                      style: TextStyle(
                        fontSize: widget.labelSize,
                        color: widget.labelColor,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
