import 'package:flutter/material.dart';

class MyListRadiosProvider with ChangeNotifier {
  
  List<bool> _myListRadiosProvider;

  MyListRadiosProvider();

  List<bool> get listRadiosBool => _myListRadiosProvider;

  set listRadiosBool(List<bool> list){
    _myListRadiosProvider = list;
    notifyListeners();
  }

}