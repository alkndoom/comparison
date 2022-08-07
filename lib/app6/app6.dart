import 'dart:math';
import 'package:flutter/material.dart';

class App6 extends StatefulWidget {
  const App6({Key? key}) : super(key: key);

  @override
  State<App6> createState() => _App6State();
}

class _App6State extends State<App6> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: pageShit(),
    );
  }
}

class pageShit extends StatefulWidget {
  const pageShit({Key? key}) : super(key: key);

  @override
  State<pageShit> createState() => _pageShitState();
}

class _pageShitState extends State<pageShit> {
  double start = 0;
  double update = 0;
  PageController pC = PageController();
  PageController oTpC = PageController();
  double val = 100;
  double lastPosition = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.black,
              child: Column(
                children: [
                  Container(
                    height: 300,
                    child: GestureDetector(
                      onHorizontalDragStart: (details) => setState(() {
                        start = details.localPosition.dx;
                      }),
                      onHorizontalDragUpdate: (details) => setState(() {
                        update = details.localPosition.dx;
                        pC.jumpTo(min(
                            max(lastPosition + start - update, 0),
                            6 * screenWidth));
                      }),
                      onHorizontalDragEnd: (details) => setState(() {
                        double v = details.velocity.pixelsPerSecond.dx;
                        lastPosition += start - update - v;
                        lastPosition =
                            min(max(lastPosition, 0), 6 * screenWidth);
                        pC.animateTo(lastPosition,
                            duration: Duration(milliseconds: 750),
                            curve: Curves.easeOut);
                      }),
                      child: PageView.builder(
                        controller: pC,
                        pageSnapping: false,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: pageElements1.length,
                        itemBuilder: (context, index) => pageElements1[index],
                      ),
                    ),
                  ),
                  Container(
                    height: 300,
                    child: PageView.builder(
                      controller: oTpC,
                      pageSnapping: false,
                      itemCount: pageElements2.length,
                      itemBuilder: (context, index) => pageElements2[index],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 590,
              left: screenWidth / 2 - 25,
              child: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors. black),
                  onPressed: () {
                    setState(() => lastPosition = 0);
                    start = 0;
                    update = 0;
                    oTpC.jumpTo(0);
                    pC.jumpTo(lastPosition);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<Widget> pageElements1 = [
  Container(
    color: Colors.red[900],
    child: const Center(
      child: Text(
        'RED',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    ),
  ),
  Container(
    color: Colors.orange[900],
    child: const Center(
      child: Text(
        'ORANGE',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    ),
  ),
  Container(
    color: Colors.yellow[900],
    child: const Center(
      child: Text(
        'YELLOW',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    ),
  ),
  Container(
    color: Colors.green[900],
    child: const Center(
      child: Text(
        'GREEN',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    ),
  ),
  Container(
    color: Colors.cyan[900],
    child: const Center(
      child: Text(
        'CYAN',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    ),
  ),
  Container(
    color: Colors.blue[900],
    child: const Center(
      child: Text(
        'BLUE',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    ),
  ),
  Container(
    color: Colors.purple[900],
    child: const Center(
      child: Text(
        'PURPLE',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    ),
  ),
];

List<Widget> pageElements2 = [
  Container(
    color: Colors.red,
    child: const Center(
      child: Text(
        'RED',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    ),
  ),
  Container(
    color: Colors.orange,
    child: const Center(
      child: Text(
        'ORANGE',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    ),
  ),
  Container(
    color: Colors.yellow,
    child: const Center(
      child: Text(
        'YELLOW',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    ),
  ),
  Container(
    color: Colors.green,
    child: const Center(
      child: Text(
        'GREEN',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    ),
  ),
  Container(
    color: Colors.cyan,
    child: const Center(
      child: Text(
        'CYAN',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    ),
  ),
  Container(
    color: Colors.blue,
    child: const Center(
      child: Text(
        'BLUE',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    ),
  ),
  Container(
    color: Colors.purple,
    child: const Center(
      child: Text(
        'PURPLE',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    ),
  ),
];
