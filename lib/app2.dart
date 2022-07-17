import 'package:flutter/material.dart';

class DummyInfo {
  static List intList = Iterable<int>.generate(15).toList();
  static List alphabetList = "abcdefghijklmnopqrstuvwxyz".split('');
}

class App2 extends StatelessWidget {
  const App2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const GirisEkrani(),
    );
  }
}

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({Key? key}) : super(key: key);

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş Ekranı"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 100,
            height: 100,
            color: Colors.blueGrey,
            child: FittedBox(
              child: Text("Giriş Ekranı"),
            ),
          ),
        ),
      ),
    );
  }
}
