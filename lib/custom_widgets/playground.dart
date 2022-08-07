import 'package:flutter/material.dart';

class Playground extends StatefulWidget {
  const Playground({Key? key}) : super(key: key);

  @override
  State<Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  double childWidgetWidth = 0;
  double childWidgetHeight = 0;
  double parentWidgetWidth = 0;
  double parentWidgetHeight = 0;
  GlobalKey key3 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Container(
          color: Colors.cyan[800],
          child: Center(
            child: Container(
              width: 300,
              height: 300,
              color: Colors.green[900],
              child: Center(
                child: Container(
                  width: 250,
                  height: 250,
                  color: key3.currentContext == null ? Colors.blue : Colors.red,
                  child: Center(
                    child: Container(
                      key: key3,
                      width: 200,
                      height: 200,
                      color: Colors.purple[900],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: kBottomNavigationBarHeight,
          child: Center(
            child: Column(
              children: [
                Text('CHILD WIDGET SIZE: ${childWidgetWidth}x$childWidgetHeight'),
                Text('PARENT WIDGET SIZE: ${parentWidgetWidth}x$parentWidgetHeight'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*class ChildWidget extends StatefulWidget {
  const ChildWidget({Key? key}) : super(key: key);

  @override
  State<ChildWidget> createState() => _ChildWidgetState();
}

class _ChildWidgetState extends State<ChildWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ChildWidgetProperties {
  final Widget widget;

  const ChildWidgetProperties(this.widget);

  RenderBox get renderBox => widget.Re

}*/


