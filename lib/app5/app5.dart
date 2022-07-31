import 'package:audioplayers/audioplayers.dart';
import 'package:comparison/app5/music_data.dart';
import 'package:flutter/material.dart';

class App5 extends StatefulWidget {
  const App5({Key? key}) : super(key: key);

  @override
  State<App5> createState() => _App5State();
}

class _App5State extends State<App5> {
  //########################################
  @override
  void initState() {
    super.initState();

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });

  }

  @override
  void dispose() {
    audioPlayer.dispose();

    super.dispose();
  }
  //########################################

  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isShuffled = false;
  bool isLooped = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  int selectedIndex = 0;
  List<MusicData> playlist = source;

  void reCreatePlaylist () {
    if (isShuffled) {
      playlist.shuffle();
    } else {
      playlist = source;
    }
  }

  Future setAudio() async {
    try {
      await audioPlayer.setSource(AssetSource(playlist[selectedIndex].musicUrl));
    } catch (e) {
      print('\n\n#### $e ####\n\n');
      return e.toString();
    }
    return null;
  }

  //########################################

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text('Music Player'),
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10.0),
                  Container(
                    width: double.infinity,
                    height: 350,
                    child: PageView.builder(
                      physics: BouncingScrollPhysics(),
                      controller: PageController(viewportFraction: 0.97, initialPage: selectedIndex),
                      onPageChanged: (index) => setState(() {
                        selectedIndex = index;
                        position = Duration.zero;
                        isPlaying = true;
                        setAudio();
                        audioPlayer.resume();
                      }),
                      itemCount: playlist.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          width: 350,
                          height: 350,
                          color: Colors.transparent,
                          child: playlist[index].coverArtUrl != null
                              ? Image.asset(playlist[index].coverArtUrl!, fit: BoxFit.cover)
                              : const Icon(Icons.warning_amber, size: 40),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 35.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 32.0),
                      Text(
                        playlist[selectedIndex].name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3.0),
                  Row(
                    children: [
                      const SizedBox(width: 32.0),
                      Text(
                        playlist[selectedIndex].artist,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          setState((){
                            position = Duration(seconds: value.toInt());
                          });
                          await audioPlayer.seek(position);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(position.toString().substring(2,7)),
                        Text(duration.toString().substring(2,7)),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 5.0),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () => setState(() {
                          isShuffled = !isShuffled;
                          reCreatePlaylist();
                        }),
                        icon: Icon(Icons.shuffle, color: isShuffled ? Colors.white : Colors.blueGrey),
                      ),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: (){},
                        icon: const Icon(Icons.skip_previous, color: Colors.white),
                        iconSize: 50,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.black45,
                        radius: 35,
                        child: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                          color: Colors.white,
                          iconSize: 50,
                          onPressed: () async {
                            if (isPlaying) {
                              await audioPlayer.pause();
                            } else {
                              await audioPlayer.resume();
                            }
                          },
                        ),
                      ),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: (){},
                        icon: const Icon(Icons.skip_next, color: Colors.white),
                        iconSize: 50,
                      ),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () => setState(() {
                          isLooped = !isLooped;
                          audioPlayer.setReleaseMode(isLooped ? ReleaseMode.loop : ReleaseMode.stop);
                        }),
                        icon: Icon(Icons.loop, color: isLooped ? Colors.white : Colors.blueGrey),
                      ),
                      const SizedBox(width: 5.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
