import 'package:flutter/cupertino.dart';

class demoController extends ChangeNotifier {
  int count = 0;

  int get counts => count;

  plusCall() {
    count++;
    notifyListeners();
  }

  minusCall() {
    count--;
    notifyListeners();
  }
}
