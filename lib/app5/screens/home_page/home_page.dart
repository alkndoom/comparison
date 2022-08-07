import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:comparison/app5/music_data.dart';
import 'package:comparison/app5/components/custom_bottom_navigation_bar.dart';
import 'package:comparison/app5/components/custom_icon_button.dart';
import 'package:comparison/app5/components/dismissable.dart';
import 'package:comparison/app5/components/main_page_row.dart';
import 'package:comparison/app5/components/mini_music_player.dart';
import 'package:comparison/app5/screens/home_page/home_page_data.dart';
import 'package:comparison/app5/sizes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final AudioPlayer audioPlayer;

  const HomePage({
    Key? key,
    required this.audioPlayer,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //########################################
  @override
  void initState() {
    super.initState();
    setAudio(playlist[queueIndex].musicUrl);
    initializeAudioPlayer();
    pageController = PageController();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    disposeAudioPlayer();
    pageController.dispose();
    scrollController.dispose();
    super.dispose();
  }
  //########################################

  AudioPlayer get player => widget.audioPlayer;
  PlayerState playerState = PlayerState.paused;

  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool get isPlaying => playerState == PlayerState.playing;
  bool isShuffled = false;
  bool isLooped = false;
  bool isRecreated = false;
  int queueIndex = 0;
  List<MusicData> playlist = [...queue];

  StreamSubscription? durationSubscription;
  StreamSubscription? positionSubscription;
  StreamSubscription? playerCompleteSubscription;
  StreamSubscription? playerStateChangeSubscription;



  Future setAudio(String music) async {
    try {
      await player.setSource(AssetSource(music));
    } catch (e) {
      print('\n\n####### $e #######\n\n');
      return e.toString();
    }
    return 'No Error';
  }

  Future<void> resume() async {
    await player.resume();
    setState(() => playerState = PlayerState.playing);
  }

  Future<void> pause() async {
    await player.pause();
    setState(() => playerState = PlayerState.paused);
  }


  void recreatePlaylist() => setState(() {
    MusicData currentElement = playlist.removeAt(queueIndex);
    if (isShuffled) {
      playlist.shuffle();
      playlist.insert(0, currentElement);
      queueIndex = 0;
    } else {
      playlist = [...queue];
      queueIndex = playlist.indexOf(currentElement);
    }
    isRecreated = true;
    pageController.jumpToPage(queueIndex);
  });

  void initializeAudioPlayer() {
    playerCompleteSubscription = player.onPlayerComplete.listen((event) => setState(() async {
      position = Duration.zero;
      if (queueIndex != playlist.length - 1) {
        queueIndex += 1;
        pageController.jumpToPage(queueIndex);
        await setAudio(playlist[queueIndex].musicUrl);
        resume();
      } else {
        if (isLooped) {
          queueIndex = 0;
          pageController.jumpToPage(queueIndex);
          await setAudio(playlist[queueIndex].musicUrl);
          resume();
        } else {
          pause();
        }
      }
    }));

    playerStateChangeSubscription = player.onPlayerStateChanged.listen((state) => setState(() {
      print('STATE: $state');
    }));

    durationSubscription = player.onDurationChanged.listen((newDuration) => setState(() {
      duration = newDuration;
    }));

    positionSubscription =  player.onPositionChanged.listen((newPosition) => setState(() {
      position = newPosition;
    }));
  }

  void disposeAudioPlayer() {
    durationSubscription?.cancel();
    positionSubscription?.cancel();
    playerCompleteSubscription?.cancel();
    playerStateChangeSubscription?.cancel();
  }


  List<Widget> widgetsToRender = [
    Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
      child: MainPageRow(
        height: Sizes.mainPageRowSlideHeightFirst,
        spaceBetweenTextAndRow: Sizes.mainPageRowSpaceBetweenTextAndRowFirst,
        titlePadding: Sizes.mainPageRowTitlePaddingFirst,
        whiteSpace: Sizes.mainPageRowWhiteSpaceFirst,
        tag: 'Recently played',
        title: const Text(
          'Recently played',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.mainPageRowTextSizeFirst,
          ),
        ),
        actions: [
          CustomIconButton(
            iconData: Icons.notifications_none,
            onPressed: () {},
          ),
          const SizedBox(width: Sizes.mainPageRowActionsSize / 2),
          CustomIconButton(
            iconData: Icons.restore,
            onPressed: () {},
          ),
          const SizedBox(width: Sizes.mainPageRowActionsSize / 2),
          CustomIconButton(
            iconData: Icons.settings_outlined,
            onPressed: () {},
          ),
        ],
        children: recentlyPlayed
            .map((r) => MainPageRowItemCard(
                  coverSize: Sizes.rowItemCardCoverSizeFirst,
                  spaceBetweenCards: Sizes.rowItemCardSpaceBetweenCardsFirst,
                  spaceBetweenTextAndCover: Sizes.rowItemCardSpaceBetweenTextAndCoverFirst,
                  centerText: r['centerText'],
                  text: r['text'],
                  textStyle: const TextStyle(
                    fontSize: Sizes.rowItemCardTextSizeFirst,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: Sizes.rowItemCardSpaceBetweenTextLinesFirst,
                  ),
                ))
            .toList(),
      ),
    ),
    ...mainPageData
        .map((e) => Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 20.0),
              child: MainPageRow(
                tag: e['titleText'],
                title: Text(
                  e['titleText'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Sizes.mainPageRowTextSize,
                  ),
                ),
                children: e['children']
                    .map(
                      (r) => MainPageRowItemCard(
                        centerText: r['centerText'],
                        text: r['text'],
                      ),
                    )
                    .toList(),
              ),
            ))
        .toList(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MainPage(

      );
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  //########################################
  @override
  void initState() {
    super.initState();
    // setAudio(playlist[queueIndex].musicUrl);
    // initializeAudioPlayer();
    pageController = PageController();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    // disposeAudioPlayer();
    pageController.dispose();
    scrollController.dispose();
    super.dispose();
  }
  //########################################

  late ScrollController scrollController;
  late PageController pageController;
  int bottomNavigationBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 0.25],
            colors: [Color(0xFF3F4646), Color(0xFF121212)],
          ),
        ),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: ListView.builder(
            controller: scrollController,
            itemCount: widgetsToRender.length,
            itemBuilder: (context, index) => widgetsToRender[index],
          ),
        ),
      ),
      bottomNavigationBar: Dismissable(
        controller: scrollController,
        child: Column(
          children: [
            GestureDetector(
              onTap: () => print('MYASSS'),
              child: MiniMusicPlayer(
                controller: pageController,
                queue: playlist,
                position: position,
                actions: [
                  CustomIconButton(
                    iconData: Icons.computer,
                    iconSize: Sizes.miniMusicPlayerActionsSize,
                    iconColor: isShuffled ? Colors.green : Colors.white,
                    width: 40.0,
                    height: 40.0,
                    onPressed: () => setState(() {
                      isShuffled = !isShuffled;
                      recreatePlaylist();
                    }),
                  ),
                  CustomIconButton(
                    iconData: playlist[queueIndex].isFavorited
                        ? Icons.favorite
                        : Icons.favorite_border,
                    iconColor: playlist[queueIndex].isFavorited
                        ? Colors.greenAccent[400]
                        : Colors.white,
                    iconSize: Sizes.miniMusicPlayerActionsSize,
                    width: 40.0,
                    height: 40.0,
                    onPressed: () => playlist[queueIndex].isFavorited = !playlist[queueIndex].isFavorited,
                  ),
                  CustomIconButton(
                    iconData: isPlaying ? Icons.pause : Icons.play_arrow,
                    iconSize: Sizes.miniMusicPlayerActionsSize,
                    width: 40.0,
                    height: 40.0,
                    onPressed: () => isPlaying ? pause() : resume(),
                  ),
                ],
                onPageChanged: (index) async {
                  if (isRecreated) {
                    setState(() => isRecreated = false);
                  } else {
                    print(index);
                    setState(() {
                      queueIndex = index;
                      position = Duration.zero;
                    });
                    await setAudio(playlist[index].musicUrl);
                    resume();
                  }
                },
              ),
            ),
            CustomBottomNavigationBar(
              items: [
                CustomBottomNavigationBarItem(
                  iconData: Icons.home_filled,
                  iconColor: bottomNavigationBarIndex == 0 ? Colors.white : Colors.grey,
                  label: 'Home',
                  labelColor: bottomNavigationBarIndex == 0 ? Colors.white : Colors.grey,
                  onPressed: () => bottomNavigationBarIndex != 0 ? setState(() => bottomNavigationBarIndex = 0) : null,
                ),
                CustomBottomNavigationBarItem(
                  iconData: Icons.my_location,
                  iconColor: bottomNavigationBarIndex == 1 ? Colors.white : Colors.grey,
                  label: 'Discover',
                  labelColor: bottomNavigationBarIndex == 1 ? Colors.white : Colors.grey,
                  onPressed: () => bottomNavigationBarIndex != 1 ? setState(() => bottomNavigationBarIndex = 1) : null,
                ),
                CustomBottomNavigationBarItem(
                  iconData: Icons.search,
                  iconColor: bottomNavigationBarIndex == 2 ? Colors.white : Colors.grey,
                  label: 'Search',
                  labelColor: bottomNavigationBarIndex == 2 ? Colors.white : Colors.grey,
                  onPressed: () => bottomNavigationBarIndex != 2 ? setState(() => bottomNavigationBarIndex = 2) : null,
                ),
                CustomBottomNavigationBarItem(
                  iconData: Icons.library_music_outlined,
                  iconColor: bottomNavigationBarIndex == 3 ? Colors.white : Colors.grey,
                  label: 'Library',
                  labelColor: bottomNavigationBarIndex == 3 ? Colors.white : Colors.grey,
                  onPressed: () => bottomNavigationBarIndex != 3 ? setState(() => bottomNavigationBarIndex = 3) : null,
                ),
                CustomBottomNavigationBarItem(
                  iconData: Icons.airplane_ticket_outlined,
                  iconColor: bottomNavigationBarIndex == 4 ? Colors.white : Colors.grey,
                  label: 'Concerts',
                  labelColor: bottomNavigationBarIndex == 4 ? Colors.white : Colors.grey,
                  onPressed: () => bottomNavigationBarIndex != 4 ? setState(() => bottomNavigationBarIndex = 4) : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
