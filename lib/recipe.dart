import 'package:flutter/material.dart';

class RecipeCard extends StatefulWidget {
  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.deepPurple[50],
            ),
            child: Column(
              children: <Widget>[
                Stack(children: <Widget>[
                  _section(5.0),
                ]),
                _section(3.0),
                _section(1.5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _section(double proportion) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height / proportion,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.deepPurple[900],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            height: MediaQuery.of(context).size.height / proportion,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.deepPurple[50],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
