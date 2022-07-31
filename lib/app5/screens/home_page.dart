import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Recently played',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.restore),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
        leading: null,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: widgetsToRender.length,
          itemBuilder: (context, index) => widgetsToRender[index],
        ),
      ),
    );
  }
}

List<Widget> widgetsToRender = [
  SizedBox(height: ),
  ListView(),
  SizedBox(height: ),
  Container(),
  SizedBox(height: ),
  ListView(),
  SizedBox(height: ),
  Container(),
  SizedBox(height: ),
  ListView(),
  SizedBox(height: ),
  Container(),
  SizedBox(height: ),
  ListView(),
  SizedBox(height: ),
  Container(),
  SizedBox(height: ),
  ListView(),
  SizedBox(height: ),
  Container(),
  SizedBox(height: ),
  ListView(),
  SizedBox(height: ),
];

List recentlyPlayed = [];

List uniquelyYours = [];

List yourTopMixes = [];

List yourShows = [];

List freshNewMusic = [];

List madeForUser = [];
