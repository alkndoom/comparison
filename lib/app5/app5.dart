import 'package:audioplayers/audioplayers.dart';
import 'package:comparison/app5/screens/concerts/concerts.dart';
import 'package:comparison/app5/screens/discover/discover.dart';
import 'package:comparison/app5/screens/home_page/home_page.dart';
import 'package:comparison/app5/screens/library/library.dart';
import 'package:comparison/app5/screens/music_options/music_options.dart';
import 'package:comparison/app5/screens/music_queue/music_queue.dart';
import 'package:comparison/app5/screens/music_screen/music_screen.dart';
import 'package:comparison/app5/screens/news/news.dart';
import 'package:comparison/app5/screens/recently_played/recently_played.dart';
import 'package:comparison/app5/screens/search/search.dart';
import 'package:comparison/app5/screens/settings/settings.dart';
import 'package:flutter/material.dart';

class App5 extends StatefulWidget {
  const App5({Key? key}) : super(key: key);

  @override
  State<App5> createState() => _App5State();
}

class _App5State extends State<App5> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/music_screen': (context) => const MusicScreen(),
        '/music_options': (context) => const MusicOptions(),
        '/discover': (context) => const Discover(),
        '/search': (context) => const Search(),
        '/library': (context) => const Library(),
        '/concerts': (context) => const Concerts(),
        '/news': (context) => const News(),
        '/recently_played': (context) => const RecentlyPlayed(),
        '/settings': (context) => const Settings(),
        '/music_queue': (context) => const MusicQueue(),
      },
    );
  }
}
