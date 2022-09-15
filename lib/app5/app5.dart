import 'package:comparison/app5/providers/custom_audio_player_provider.dart';
import 'package:comparison/app5/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App5 extends StatefulWidget {
  const App5({Key? key}) : super(key: key);

  @override
  State<App5> createState() => _App5State();
}

class _App5State extends State<App5> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomAudioPlayerProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark().copyWith(secondary: Colors.grey)),
        home: const MainPage(),
      ),
    );
  }
}
