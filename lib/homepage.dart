import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'recipe.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

int count = 1;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        elevation: 20,
        onPressed: () {
          setState(() {
            count++;
          });
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: false,
            expandedHeight: 120.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text("Recipe Planner"),
            ),
            centerTitle: true,
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          SliverToBoxAdapter(child: RecipeCardList()),
        ],
      ),
    );
  }
}

class RecipeCardList extends StatefulWidget {
  @override
  _RecipeCardListState createState() => _RecipeCardListState();
}

class _RecipeCardListState extends State<RecipeCardList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RecipeCard();
                }));
              },
              child: Container(
                height: 200,
                child: Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  actions: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.redAccent,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ),
                              Text("Like",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  secondaryActions: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black87,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              Text("Delete",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 10,
                      child: Row(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 8, bottom: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.pinkAccent,
                                ),
                                width: MediaQuery.of(context).size.width / 3,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 10, right: 8, bottom: 8),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.84,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.deepPurple[200],
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 5),
                                    Text("Heading",
                                        style: TextStyle(
                                          fontSize: 24,
                                        )),
                                    Text("Sub heading",
                                        style: TextStyle(
                                          fontSize: 18,
                                        )),
                                    SizedBox(height: 10),
                                    Text("Ingredients:",
                                        style: TextStyle(
                                          fontSize: 18,
                                        )),
                                    Text("Course:",
                                        style: TextStyle(
                                          fontSize: 18,
                                        )),
                                    Text("Prep Time:",
                                        style: TextStyle(
                                          fontSize: 18,
                                        )),
                                    Text("Cuisine:",
                                        style: TextStyle(
                                          fontSize: 18,
                                        )),
                                  ]),
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),
          );
        });
  }

  _deleteCard() {}
}
