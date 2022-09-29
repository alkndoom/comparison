import 'dart:async';
import 'dart:math';

import 'package:comparison/app5_spotify_clone/src/domain/entities/music_data.dart';
import 'package:comparison/app5_spotify_clone/src/core/providers/custom_audio_player_provider.dart';
import 'package:comparison/app5_spotify_clone/sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MiniMusicPlayer extends StatefulWidget {
  final List<MusicData> queue;
  final List<Widget>? actions;
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
    required this.controller,
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
  ///
  ///################################################################################
  ///
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(listen);

    reader = Provider.of<CustomAudioPlayerProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.jumpToPage(reader.pageIndex);
    });

    initializeAudioPlayer();
  }

  @override
  void dispose() {
    widget.controller.removeListener(listen);

    disposeAudioPlayer();
    super.dispose();
  }
  ///
  ///################################################################################
  ///
  late int indexAfterScroll;
  double controllerPosition = 0;
  bool isPointerUp = false;
  bool isPageChanged = false;
  late CustomAudioPlayerProvider reader;
  StreamSubscription? positionSubscription;
  StreamSubscription? durationSubscription;
  StreamSubscription? playerCompleteSubscription;

  int get selectedIndex =>
      Provider
          .of<CustomAudioPlayerProvider>(context, listen: false)
          .pageIndex;

  Duration get position =>
      Provider
          .of<CustomAudioPlayerProvider>(context, listen: false)
          .position;

  Duration get duration =>
      Provider
          .of<CustomAudioPlayerProvider>(context, listen: false)
          .duration;
  ///
  ///################################################################################
  ///
  void listen() => setState(() => controllerPosition = widget.controller.position.pixels);

  Future<void> changePage() async {
    if (isPageChanged & isPointerUp) {
      isPageChanged = false;
      isPointerUp = false;
      await widget.controller.animateToPage(
        indexAfterScroll,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
      if (indexAfterScroll == selectedIndex + 1) {
        await reader.next();
      } else if (indexAfterScroll == selectedIndex - 1) {
        await reader.previous();
      }
      widget.controller.jumpToPage(reader.pageIndex);
    }
  }

  void initializeAudioPlayer() {
    playerCompleteSubscription = reader.player.onPlayerComplete.listen((_) async {
      await reader.stop();
      await reader.resume();
    });

    durationSubscription = reader.player.onDurationChanged.listen((duration) => reader.duration = duration);

    positionSubscription = reader.player.onPositionChanged.listen((position) => reader.position = position);
  }

  void disposeAudioPlayer() {
    durationSubscription?.cancel();
    positionSubscription?.cancel();
    playerCompleteSubscription?.cancel();
  }
  ///
  ///################################################################################
  ///

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: const Color(0xFF454545),
          ),
          width: MediaQuery
              .of(context)
              .size
              .width - 2 * widget.horizontalPadding,
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
                    child: widget.queue[selectedIndex].coverArtUrl != null ? Image.asset(widget.queue[selectedIndex].coverArtUrl!) : const Icon(Icons.warning_amber),
                  ),
                ),
              ),
              SizedBox(width: widget.spaceBetweenTextAndCover),
              Expanded(
                child: Listener(
                  onPointerDown: (_) {
                    isPointerUp = false;
                  },
                  onPointerUp: (_) async {
                    isPointerUp = true;
                    await changePage();
                  },
                  child: LayoutBuilder(
                    builder: (context, constraints) =>
                        Theme(
                          data: Theme.of(context).copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.grey)),
                          child: PageView.builder(
                            controller: widget.controller,
                            onPageChanged: (index) async {
                              indexAfterScroll = index;
                              if (selectedIndex != indexAfterScroll) {
                                isPageChanged = true;
                              }
                              await changePage();
                            },
                            itemBuilder: (context, index) {
                              controllerPosition = widget.controller.position.pixels;
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
                                      style: TextStyle(fontSize: widget.textSize, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      widget.queue[index].artist,
                                      style: TextStyle(
                                        fontSize: widget.textSize,
                                        color: Colors.grey,
                                      ),
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
              ),
              SizedBox(width: widget.spaceBetweenTextAndActions),
              ...?widget.actions,
              SizedBox(width: (widget.height - widget.coverSize) / 2),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: (widget.height - widget.coverSize) / 2,
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width - widget.height + widget.coverSize - 2 * widget.horizontalPadding,
            height: 3.0,
            color: Colors.grey,
          ),
        ),
        Positioned(
          bottom: 0,
          left: (widget.height - widget.coverSize) / 2,
          child: Container(
            width: min(position.inMilliseconds.toDouble() / duration.inMilliseconds.toDouble(), 1) *
                (MediaQuery
                    .of(context)
                    .size
                    .width - widget.height + widget.coverSize - 2 * widget.horizontalPadding),
            height: 3.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
