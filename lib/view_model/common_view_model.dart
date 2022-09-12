import 'package:flutter/material.dart';
class CommonViewModel with ChangeNotifier{
  bool isLoading = false;
  onNotifierChange(){
    notifyListeners();
  }
}