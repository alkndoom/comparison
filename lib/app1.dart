import 'package:flutter/material.dart';

class DummyInfo {
  static List intList = Iterable<int>.generate(15).toList();
  static List alphabetList = "abcdefghijklmnopqrstuvwxyz".split('');
}

class App1 extends StatelessWidget {
  const App1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Listeci(),
    );
  }
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

  void goToPage(String item) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Sayfa(item)),
    );
  }

  //########################################

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listeci"),
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
                  item.toUpperCase(),
                  style: const TextStyle(
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
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_border),
              ),
              onTap: () {
                goToPage(item);
              },
              title: Text(item),
            );
          },
        ),
      ),
    );
  }
}

class Sayfa extends StatelessWidget {
  final String item;

  const Sayfa(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          item.toUpperCase(),
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 100,
            height: 100,
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}
