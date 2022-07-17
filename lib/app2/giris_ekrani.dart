import 'package:flutter/material.dart';

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
            width: 150,
            height: 100,
            color: Colors.blueGrey,
            padding: EdgeInsets.all(9.0),
            child: FittedBox(
              child: Text("Giriş Ekranı"),
            ),
          ),
        ),
      ),
    );
  }
}
