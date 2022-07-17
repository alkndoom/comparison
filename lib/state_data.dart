import 'package:flutter/material.dart';

class StateData extends ChangeNotifier {
  List app1Selections = [];

  void app1SelectionsAdd(String item) {
    app1Selections.add(item);
    notifyListeners();
  }

  void app1SelectionsRemove(String item) {
    app1Selections.remove(item);
    notifyListeners();
  }
}
