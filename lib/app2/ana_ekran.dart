import 'package:flutter/material.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({Key? key}) : super(key: key);

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ana Ekran"),
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
              child: Text("Ana Ekran"),
            ),
          ),
        ),
      ),
    );
  }
}
