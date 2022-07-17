import 'package:comparison/app2/screens/wrapper.dart';
import 'package:flutter/material.dart';

class DummyInfo {
  static List intList = Iterable<int>.generate(15).toList();
  static List alphabetList = "abcdefghijklmnopqrstuvwxyz".split('');
}

class App2 extends StatefulWidget {
  const App2({Key? key}) : super(key: key);

  @override
  State<App2> createState() => _App2State();
}

class _App2State extends State<App2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Wrapper(),
    );
  }
}
