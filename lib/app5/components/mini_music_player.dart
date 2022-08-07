import 'dart:math';
import 'package:comparison/app5/music_data.dart';
import 'package:flutter/material.dart';

import 'package:comparison/app5/sizes.dart';

typedef ValueChanged<T> = void Function(T value);

class MiniMusicPlayer extends StatefulWidget {
  final List<MusicData> queue;
  final List<Widget>? actions;
  final Duration position;
  final ValueChanged<int>? onPageChanged;
  final double height;
  final double horizontalPadding;
  final double coverSize;
  final double textSize;
  final double spaceBetweenTextAndCover;
  final double spaceBetweenTextAndActions;
  final PageController controller;

  const MiniMusicPlayer({
    Key? key,
    required this.queue,
    required this.position,
    required this.controller,
    this.onPageChanged,
    this.height = Sizes.miniMusicPlayerHeight,
    this.spaceBetweenTextAndCover = Sizes.miniMusicPlayerSpaceBetweenTextAndCover,
    this.horizontalPadding = Sizes.miniMusicPlayerHorizontalPadding,
    this.coverSize = Sizes.miniMusicPlayerCoverSize,
    this.textSize = Sizes.miniMusicPlayerTextSize,
    this.spaceBetweenTextAndActions = Sizes.miniMusicPlayerSpaceBetweenTextAndActions,
    this.actions,
  }) : super(key: key);

  @override
  State<MiniMusicPlayer> createState() => _MiniMusicPlayerState();
}

class _MiniMusicPlayerState extends State<MiniMusicPlayer> {
  int selectedIndex = 0;
  double controllerPosition = 0;

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

  void listen() => setState(() => controllerPosition = widget.controller.position.pixels);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: const Color(0xFF454545),
          ),
          width: MediaQuery.of(context).size.width - 2 * widget.horizontalPadding,
          height: widget.height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all((widget.height - widget.coverSize) / 2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    height: widget.coverSize,
                    width: widget.coverSize,
                    color: Colors.transparent,
                    child: widget.queue[selectedIndex].coverArtUrl != null
                        ? Image.asset(widget.queue[selectedIndex].coverArtUrl!)
                        : const Icon(Icons.warning_amber),
                  ),
                ),
              ),
              SizedBox(width: widget.spaceBetweenTextAndCover),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) => Theme(
                    data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.grey)),
                    child: PageView.builder(
                      controller: widget.controller,
                      onPageChanged: (index) {
                        setState(() => selectedIndex = index);
                        widget.onPageChanged != null ? widget.onPageChanged!(selectedIndex) : null;
                      },
                      itemBuilder: (context, index) {
                        double distance = (controllerPosition - index * constraints.maxWidth).abs();
                        double opacity = 1;
                        if (distance >= constraints.maxWidth / 2) {
                          opacity = 0;
                        } else {
                          opacity = 1 - 2 * distance / constraints.maxWidth;
                        }
                        return Opacity(
                          opacity: opacity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.queue[index].name,
                                style: TextStyle(
                                    fontSize: widget.textSize, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.queue[index].artist,
                                style: TextStyle(fontSize: widget.textSize, color: Colors.grey),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: widget.queue.length,
                    ),
                  ),
                ),
              ),
              SizedBox(width: widget.spaceBetweenTextAndActions),
              ...?widget.actions,
              SizedBox(width: (widget.height - widget.coverSize) / 2),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: widget.horizontalPadding,
          child: Container(
            width: MediaQuery.of(context).size.width - 2 * widget.horizontalPadding,
            height: 3.0,
            color: Colors.grey,
          ),
        ),
        Positioned(
          bottom: 0,
          left: widget.horizontalPadding,
          child: Container(
            width: min(
                    widget.position.inMilliseconds.toDouble() /
                        widget.queue[selectedIndex].duration.inMilliseconds.toDouble(),
                    1) *
                (MediaQuery.of(context).size.width - 2 * widget.horizontalPadding),
            height: 3.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
