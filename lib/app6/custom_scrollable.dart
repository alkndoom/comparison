import 'dart:math';
import 'package:flutter/material.dart';

typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index);

class CustomScrollable extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final PageController controller;
  final int? itemCount;
  final bool pageSnapping;

  const CustomScrollable({
    Key? key,
    required this.itemBuilder,
    required this.controller,
    this.itemCount,
    this.pageSnapping = true,
  }) : super(key: key);

  @override
  State<CustomScrollable> createState() => _CustomScrollableState();
}

class _CustomScrollableState extends State<CustomScrollable> {
  double start = 0;
  double update = 0;
  double velocity = 0;
  double lastPosition = 0;
  double renderSize = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) =>
          setState(() {
            start = details.localPosition.dx;
          }),
      onHorizontalDragUpdate: (details) =>
          setState(() {
            update = details.localPosition.dx;
            widget.controller.jumpTo(min(max(lastPosition + start - update, 0), renderSize));
          }),
      onHorizontalDragEnd: (details) =>
          setState(() {
            velocity = details.velocity.pixelsPerSecond.dx;
            lastPosition += start - update - velocity;
            lastPosition = min(max(lastPosition, 0), renderSize);
            widget.controller.animateTo(
              lastPosition,
              duration: const Duration(milliseconds: 750),
              curve: Curves.easeOut,
            );
          }),
      child: PageView.builder(
        controller: widget.controller,
        pageSnapping: widget.pageSnapping,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.itemCount,
        itemBuilder: widget.itemBuilder,
      ),
    );
  }
}
