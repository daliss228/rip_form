import 'package:flutter/material.dart';
import 'package:ripconciv_app/src/pages/form_page.dart';
import 'package:ripconciv_app/src/pages/home_page.dart';
import 'package:ripconciv_app/src/pages/login_page.dart';

Map<String, WidgetBuilder> getRoutes(){

  return <String, WidgetBuilder>{
    '/': (BuildContext context) => LoginPage(),
    'form': (BuildContext context) => FormPage(),
    'home': (BuildContext context) => HomePage()
  };
  
}