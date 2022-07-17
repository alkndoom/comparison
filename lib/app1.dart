import 'package:flutter/material.dart';

class DummyInfo {
  static List intList = Iterable<int>.generate(15).toList();
  static List alphabetList = [
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z"
  ];
}

class Listeci extends StatefulWidget {
  const Listeci({Key? key}) : super(key: key);

  @override
  State<Listeci> createState() => _ListeciState();
}

class _ListeciState extends State<Listeci> {
  //########################################
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  //########################################

  List selections = [];

  void selectTile(String item) {
    setState(() {
      selections.contains(item)
          ? selections.remove(item)
          : selections.add(item);
    });
  }

  //########################################

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listeci"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: DummyInfo.alphabetList.length,
          itemBuilder: (context, index) {
            String item = DummyInfo.alphabetList[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Text(
                  "${item.toUpperCase()}",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  selectTile(item);
                },
                splashRadius: 20,
                icon: selections.contains(item)
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),
              ),
              onTap: () {
                selectTile(item);
              },
              title: Text("$item"),
            );
          },
        ),
      ),
    );
  }
}
