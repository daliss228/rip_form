import 'package:flutter/material.dart';
import 'package:ripconciv_app/src/routes/routes.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ripconciv App',
      theme: ThemeData.light(),
      initialRoute: '/',
      routes: getRoutes(),
    );
  }
}