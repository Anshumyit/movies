

import 'package:flutter/cupertino.dart';

class BottomNavitor with ChangeNotifier{
  int currentindex=0;

  void selectedscreenChange(int index){
    currentindex=index;
    notifyListeners(); }
}