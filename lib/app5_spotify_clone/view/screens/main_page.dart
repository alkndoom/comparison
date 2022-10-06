import 'package:comparison/app5_spotify_clone/view/components/custom_bottom_navigation_bar.dart';
import 'package:comparison/app5_spotify_clone/view/components/custom_icon_button.dart';
import 'package:comparison/app5_spotify_clone/view/components/dismissable.dart';
import 'package:comparison/app5_spotify_clone/view/components/mini_music_player.dart';
import 'package:comparison/app5_spotify_clone/view/providers/custom_audio_player_provider.dart';
import 'package:comparison/app5_spotify_clone/view/screens/custom_page_route.dart';
import 'package:comparison/app5_spotify_clone/view/screens/home/home.dart';
import 'package:comparison/app5_spotify_clone/view/screens/library/library.dart';
import 'package:comparison/app5_spotify_clone/view/screens/music_screen/music_screen.dart';
import 'package:comparison/app5_spotify_clone/view/screens/search/search.dart';
import 'package:comparison/app5_spotify_clone/sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ///
  ///################################################################################
  ///
  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();
    miniMusicPlayerPageController = PageController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    miniMusicPlayerPageController.dispose();

    super.dispose();
  }
  ///
  ///################################################################################
  ///
  late ScrollController scrollController;
  late PageController miniMusicPlayerPageController;

  int bottomNavigationBarIndex = 0;
  ///
  ///################################################################################
  ///

  @override
  Widget build(BuildContext context) {
    final watcher = Provider.of<CustomAudioPlayerProvider>(context);
    final reader = Provider.of<CustomAudioPlayerProvider>(context, listen: false);
    final List<Widget> pages = [
      Home(scrollController: scrollController, tag: 'Home'),
      Search(scrollController: scrollController, tag: 'Search'),
      Library(scrollController: scrollController, tag: 'Library'),
    ];
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        extendBody: true,
        body: pages[bottomNavigationBarIndex],
        bottomNavigationBar: Dismissable(
          controller: scrollController,
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  //if (!mounted) return;
                  await Navigator.push(context, CustomPageRoute(child: const MusicScreen()));
                  reader.createPlaylist();
                  miniMusicPlayerPageController.jumpToPage(reader.pageIndex);
                }
                ,
                child: watcher.playlist.isNotEmpty
                    ? MiniMusicPlayer(
                        controller: miniMusicPlayerPageController,
                        queue: watcher.playlist,
                        actions: [
                          CustomIconButton(
                            iconData: Icons.shuffle,
                            iconSize: Sizes.miniMusicPlayerActionsSize,
                            iconColor: watcher.isShuffled ? Colors.green : Colors.white,
                            width: 40.0,
                            height: 40.0,
                            onPressed: () async {
                              reader.isShuffled = !watcher.isShuffled;
                              await reader.organizeQueue();
                              miniMusicPlayerPageController.jumpToPage(reader.pageIndex);
                            },
                          ),
                          CustomIconButton(
                            iconData: watcher.playlist[watcher.pageIndex].isFavorited ? Icons.favorite : Icons.favorite_border,
                            iconColor: watcher.playlist[watcher.pageIndex].isFavorited ? Colors.greenAccent[400] : Colors.white,
                            iconSize: Sizes.miniMusicPlayerActionsSize,
                            width: 40.0,
                            height: 40.0,
                            onPressed: () {
                              reader.queue[reader.queueIndex].isFavorited != reader.queue[reader.queueIndex].isFavorited;
                            },
                          ),
                          CustomIconButton(
                            iconData: watcher.isPlaying ? Icons.pause : Icons.play_arrow,
                            iconSize: Sizes.miniMusicPlayerActionsSize,
                            width: 40.0,
                            height: 40.0,
                            onPressed: () async {
                              if (watcher.isPlaying) {
                                await reader.pause();
                              } else {
                                await reader.resume();
                              }
                            },
                          ),
                        ],
                      )
                    : Container(),
              ),
              CustomBottomNavigationBar(
                items: [
                  CustomBottomNavigationBarItem(
                    iconData: Icons.home_filled,
                    iconColor: bottomNavigationBarIndex == 0 ? Colors.white : Colors.grey,
                    label: 'Home',
                    labelColor: bottomNavigationBarIndex == 0 ? Colors.white : Colors.grey,
                    onPressed: () => bottomNavigationBarIndex != 0 ? setState(() => bottomNavigationBarIndex = 0): null,
                  ),
                  CustomBottomNavigationBarItem(
                    iconData: Icons.search,
                    iconColor: bottomNavigationBarIndex == 1 ? Colors.white : Colors.grey,
                    label: 'Search',
                    labelColor: bottomNavigationBarIndex == 1 ? Colors.white : Colors.grey,
                    onPressed: () => bottomNavigationBarIndex != 1 ? setState(() => bottomNavigationBarIndex = 1): null,
                  ),
                  CustomBottomNavigationBarItem(
                    iconData: Icons.library_music_outlined,
                    iconColor: bottomNavigationBarIndex == 2 ? Colors.white : Colors.grey,
                    label: 'Library',
                    labelColor: bottomNavigationBarIndex == 2 ? Colors.white : Colors.grey,
                    onPressed: () => bottomNavigationBarIndex != 2 ? setState(() => bottomNavigationBarIndex = 2): null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
