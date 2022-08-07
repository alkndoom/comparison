import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:comparison/app5/sizes.dart';

class Dismissable extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration duration;
  final double allowedHeight;

  const Dismissable({
    Key? key,
    required this.child,
    required this.controller,
    this.duration = const Duration(milliseconds: 200),
    this.allowedHeight = Sizes.bottomNavigationBarHeight + Sizes.miniMusicPlayerHeight,
  }) : super(key: key);

  @override
  State<Dismissable> createState() => _DismissableState();
}

class _DismissableState extends State<Dismissable> {
  bool isVisible = true;

  //########################################
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(listen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listen);

    super.dispose();
  }

  //########################################

  void listen() {
    final direction = widget.controller.position.userScrollDirection;

    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  void show() {
    if (!isVisible) setState(() => isVisible = true);
  }

  void hide() {
    if (isVisible) setState(() => isVisible = false);
  }

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: widget.duration,
        height: isVisible ? widget.allowedHeight : 0,
        child: Align(alignment: Alignment.bottomCenter, child: Wrap(children: [widget.child])),
      );
}
