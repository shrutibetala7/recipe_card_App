import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          fontFamily: 'IndieFlower',
          textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 24, letterSpacing: 1, fontWeight: FontWeight.w700),
            headline2: TextStyle(
                fontSize: 20, letterSpacing: 1, fontWeight: FontWeight.w600),
            bodyText1: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          )),
      home: RecipeCardList(),
    );
  }
}
