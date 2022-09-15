import 'dart:async';
import 'package:comparison/app5/components/custom_icon_button.dart';
import 'package:comparison/app5/providers/custom_audio_player_provider.dart';
import 'package:comparison/app5/sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:palette_generator/palette_generator.dart';

class MusicScreen extends StatefulWidget {

  const MusicScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  ///
  ///################################################################################
  ///
  @override
  void initState() {
    super.initState();

    controller = PageController();

    reader = Provider.of<CustomAudioPlayerProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.jumpToPage(reader.pageIndex);
    });

    initializeAudioPlayer();
  }

  @override
  void dispose() {
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
  late PageController controller;
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
  Future<void> changePage() async {
    if (isPageChanged & isPointerUp) {
      isPageChanged = false;
      isPointerUp = false;
      await controller.animateToPage(
        indexAfterScroll,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
      if (indexAfterScroll == selectedIndex + 1) {
        await reader.next();
      } else if (indexAfterScroll == selectedIndex - 1) {
        await reader.previous();
      }
      controller.jumpToPage(reader.pageIndex);
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

  /*Color? gradientColor = Colors.blue[800];

  Future<void> updatePalettes() async {
    final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
      AssetImage(music.coverArtUrl!),
      size: Size(350, 350),
    );

    gradientColor = generator.lightMutedColor?.color != null ? generator.lightMutedColor!.color : Colors.blue[800];
    setState(() {});
  }*/

  //########################################

  @override
  Widget build(BuildContext context) {
    final watcher = Provider.of<CustomAudioPlayerProvider>(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0, 1],
                colors: [Color(0xFF121212),
                  Color(0xFF660099)],
                  //Color(0xFF5b5b5b)],
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Listener(
              onPointerDown: (_) {
                isPointerUp = false;
              },
              onPointerUp: (_) async {
                isPointerUp = true;
                await changePage();
              },
              child: PageView.builder(
                physics: const ClampingScrollPhysics(),
                controller: controller,
                onPageChanged: (index) async {
                  indexAfterScroll = index;
                  if (selectedIndex != indexAfterScroll) {
                    isPageChanged = true;
                  }
                  await changePage();
                },
                itemCount: watcher.playlist.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: Sizes.musicScreenCoverArtBottomSpace,
                      left: (MediaQuery.of(context).size.width - Sizes.musicScreenCoverArtSize) / 2,
                      right: (MediaQuery.of(context).size.width - Sizes.musicScreenCoverArtSize) / 2,
                    ),
                    child: Container(
                      width: Sizes.musicScreenCoverArtSize,
                      height: Sizes.musicScreenCoverArtSize,
                      color: Colors.transparent,
                      child: watcher.playlist[index].coverArtUrl != null
                          ? Image.asset(watcher.playlist[index].coverArtUrl!)
                          : const Icon(Icons.warning_amber, size: 40),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 50.0,
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.musicScreenItemsPadding,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                watcher.playlist[selectedIndex].name,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 1.0),
                              Text(
                                watcher.playlist[selectedIndex].artist,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          CustomIconButton(
                            iconData: watcher.playlist[selectedIndex].isFavorited ? Icons.favorite : Icons.favorite_border,
                            iconColor: watcher.playlist[selectedIndex].isFavorited ? Colors.greenAccent[400] : Colors.white,
                            iconSize: 25.0,
                            width: 25.0,
                            height: 25.0,
                            onPressed: () {
                              reader.queue[reader.queueIndex].isFavorited != reader.queue[reader.queueIndex].isFavorited;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 7.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.musicScreenSliderPadding,
                      ),
                      child: SliderTheme(
                        data: const SliderThemeData(
                          trackShape: RectangularSliderTrackShape(),
                          trackHeight: 3.0,
                          thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: 5.0,
                          ),
                        ),
                        child: Slider(
                          activeColor: Colors.white,
                          inactiveColor: Colors.blueGrey.withOpacity(0.3),
                          min: 0,
                          max: duration.inSeconds.toDouble(),
                          value: position.inSeconds.toDouble(),
                          onChanged: (value) async {
                            reader.position = Duration(seconds: value.toInt());
                            await reader.player.seek(position);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal:
                            Sizes.musicScreenItemsPadding + Sizes.musicScreenSliderPadding / 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            position.toString().substring(2, 7),
                            style: const TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            duration.toString().substring(2, 7),
                            style: const TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.musicScreenItemsPadding,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomIconButton(
                            iconData: Icons.shuffle,
                            iconColor: watcher.isShuffled ? Colors.green : Colors.white,
                            iconSize: 25.0,
                            onPressed: () async {
                              reader.isShuffled = !watcher.isShuffled;
                              await reader.organizeQueue();
                              controller.jumpToPage(reader.pageIndex);
                            },
                          ),
                          CustomIconButton(
                            iconData: Icons.skip_previous,
                            iconSize: 45.0,
                            onPressed: () async {
                              if (watcher.isLooped || watcher.queueIndex != 0) {
                                reader.pageIndex -= 1;
                                await controller.animateToPage(
                                  selectedIndex,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeOut,
                                );
                                await reader.previous();
                                controller.jumpToPage(reader.pageIndex);
                              }
                            },
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30.0,
                            child: CustomIconButton(
                              iconData: watcher.isPlaying ? Icons.pause : Icons.play_arrow,
                              iconColor: Colors.black,
                              iconSize: 35.0,
                              onPressed: () async {
                                if (watcher.isPlaying) {
                                  await reader.pause();
                                } else {
                                  await reader.resume();
                                }
                              },
                            ),
                          ),
                          CustomIconButton(
                            iconData: Icons.skip_next,
                            iconSize: 45.0,
                            onPressed: () async {
                              if (watcher.isLooped || watcher.queueIndex != watcher.queue.length - 1) {
                                reader.pageIndex += 1;
                                await controller.animateToPage(
                                  selectedIndex,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeOut,
                                );
                                await reader.next();
                                controller.jumpToPage(reader.pageIndex);
                              }
                            },
                          ),
                          CustomIconButton(
                            iconData: Icons.loop,
                            iconColor: watcher.isLooped ? Colors.green : Colors.white,
                            iconSize: 25.0,
                            onPressed: () async {
                              reader.isLooped = !watcher.isLooped;
                              await reader.organizeQueue();
                              controller.jumpToPage(reader.pageIndex);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          Positioned(
            top: 40.0,
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                      iconData: Icons.keyboard_arrow_down_outlined,
                      iconSize: 25.0,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'PLAYING FROM ARTIST',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8.0,
                          ),
                        ),
                        const SizedBox(height: 1.0),
                        Text(
                          watcher.playlist[selectedIndex].artist,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 11.0,
                          ),
                        ),
                      ],
                    ),
                    CustomIconButton(
                      iconData: Icons.more_vert,
                      iconSize: 25.0,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}