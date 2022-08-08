import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:comparison/app5/components/custom_bottom_navigation_bar.dart';
import 'package:comparison/app5/components/custom_icon_button.dart';
import 'package:comparison/app5/components/dismissable.dart';
import 'package:comparison/app5/components/main_page_row.dart';
import 'package:comparison/app5/components/mini_music_player.dart';
import 'package:comparison/app5/music_data.dart';
import 'package:comparison/app5/screens/home_page/home_page_data.dart';
import 'package:comparison/app5/sizes.dart';
import 'package:flutter/material.dart';

class CustomAudioPlayer {
  AudioPlayer player = AudioPlayer();
  PlayerState playerState = PlayerState.paused;
  bool isShuffled = false;
  bool isLooped = false;
  bool isRecreated = false;
  int queueIndex = 0;
  List<MusicData> playlist = [...queue];

  void recreatePlaylist() {
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
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //########################################
  @override
  void initState() {
    super.initState();
    customAudioPlayer = CustomAudioPlayer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //########################################

  late CustomAudioPlayer customAudioPlayer;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MainPage(
        playerData: customAudioPlayer,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final CustomAudioPlayer playerData;

  const MainPage({
    Key? key,
    required this.playerData,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //########################################
  @override
  void initState() {
    super.initState();
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

  void initializeAudioPlayer() {
    setAudio(music.musicUrl, playerData);

    positionSubscription = playerData.player.onPositionChanged.listen((newPosition) => setState(() {
          position = newPosition;
        }));
  }

  void disposeAudioPlayer() {
    positionSubscription?.cancel();
  }

  Future setAudio(String music, CustomAudioPlayer customAudioPlayer) async {
    try {
      await customAudioPlayer.player.setSource(AssetSource(music));
    } catch (e) {
      print('\n\n####### $e #######\n\n');
      return e.toString();
    }
    return 'No Error';
  }

  Future<void> resume(CustomAudioPlayer customAudioPlayer) async {
    await customAudioPlayer.player.resume();
    setState(() => customAudioPlayer.playerState = PlayerState.playing);
  }

  Future<void> pause(CustomAudioPlayer customAudioPlayer) async {
    await customAudioPlayer.player.pause();
    setState(() => customAudioPlayer.playerState = PlayerState.paused);
  }

  //########################################

  CustomAudioPlayer get playerData => widget.playerData;

  List<MusicData> get playlist => playerData.playlist;

  MusicData get music => playlist[playerData.queueIndex];

  bool get isPlaying => playerData.playerState == PlayerState.playing;

  Duration position = Duration.zero;

  StreamSubscription? positionSubscription;

  late ScrollController scrollController;
  late PageController pageController;
  int bottomNavigationBarIndex = 0;

  //########################################

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
                    iconColor: playerData.isShuffled ? Colors.green : Colors.white,
                    width: 40.0,
                    height: 40.0,
                    onPressed: () => setState(() {
                      playerData.isShuffled = !playerData.isShuffled;
                      playerData.recreatePlaylist();
                      pageController.jumpToPage(playerData.queueIndex);
                    }),
                  ),
                  CustomIconButton(
                    iconData: music.isFavorited ? Icons.favorite : Icons.favorite_border,
                    iconColor: music.isFavorited ? Colors.greenAccent[400] : Colors.white,
                    iconSize: Sizes.miniMusicPlayerActionsSize,
                    width: 40.0,
                    height: 40.0,
                    onPressed: () => setState(() => playerData.playlist[playerData.queueIndex]
                        .isFavorited = !playerData.playlist[playerData.queueIndex].isFavorited),
                  ),
                  CustomIconButton(
                    iconData: isPlaying ? Icons.pause : Icons.play_arrow,
                    iconSize: Sizes.miniMusicPlayerActionsSize,
                    width: 40.0,
                    height: 40.0,
                    onPressed: () => isPlaying ? pause(playerData) : resume(playerData),
                  ),
                ],
                onPageChanged: (index) async {
                  if (playerData.isRecreated) {
                    playerData.isRecreated = false;
                  } else {
                    setState(() {
                      playerData.queueIndex = index;
                      position = Duration.zero;
                    });
                    await setAudio(music.musicUrl, playerData);
                    resume(playerData);
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
                  onPressed: () => bottomNavigationBarIndex != 0
                      ? setState(() => bottomNavigationBarIndex = 0)
                      : null,
                ),
                CustomBottomNavigationBarItem(
                  iconData: Icons.my_location,
                  iconColor: bottomNavigationBarIndex == 1 ? Colors.white : Colors.grey,
                  label: 'Discover',
                  labelColor: bottomNavigationBarIndex == 1 ? Colors.white : Colors.grey,
                  onPressed: () => bottomNavigationBarIndex != 1
                      ? setState(() => bottomNavigationBarIndex = 1)
                      : null,
                ),
                CustomBottomNavigationBarItem(
                  iconData: Icons.search,
                  iconColor: bottomNavigationBarIndex == 2 ? Colors.white : Colors.grey,
                  label: 'Search',
                  labelColor: bottomNavigationBarIndex == 2 ? Colors.white : Colors.grey,
                  onPressed: () => bottomNavigationBarIndex != 2
                      ? setState(() => bottomNavigationBarIndex = 2)
                      : null,
                ),
                CustomBottomNavigationBarItem(
                  iconData: Icons.library_music_outlined,
                  iconColor: bottomNavigationBarIndex == 3 ? Colors.white : Colors.grey,
                  label: 'Library',
                  labelColor: bottomNavigationBarIndex == 3 ? Colors.white : Colors.grey,
                  onPressed: () => bottomNavigationBarIndex != 3
                      ? setState(() => bottomNavigationBarIndex = 3)
                      : null,
                ),
                CustomBottomNavigationBarItem(
                  iconData: Icons.airplane_ticket_outlined,
                  iconColor: bottomNavigationBarIndex == 4 ? Colors.white : Colors.grey,
                  label: 'Concerts',
                  labelColor: bottomNavigationBarIndex == 4 ? Colors.white : Colors.grey,
                  onPressed: () => bottomNavigationBarIndex != 4
                      ? setState(() => bottomNavigationBarIndex = 4)
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
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
