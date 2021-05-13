import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'recipe.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:recipe_app/models/recipe_database.dart';
import 'package:recipe_app/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class RecipeCardList extends StatefulWidget {
  @override
  _RecipeCardListState createState() => _RecipeCardListState();
}

class _RecipeCardListState extends State<RecipeCardList> {
  List<Recipe_info> rec;
  DatabaseHelper dbhelper = DatabaseHelper();
  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (rec == null) {
      // ignore: deprecated_member_use
      rec = List<Recipe_info>();
      updateRecipeView();
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        elevation: 20,
        onPressed: () {
          setState(() {
            navigateToDetail(Recipe_info(''));
            //updateRecipeView();
          });
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: false,
            floating: false,
            pinned: false,
            expandedHeight: 90.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text("Recipe Planner"),
            ),
            centerTitle: true,
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          SliverFillRemaining(
            child: ListView.builder(
                shrinkWrap: true,
                primary: true,
                itemCount: count,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        navigateToDetail(this.rec[index]);
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
                              onTap: () {
                                _delete(context, rec[index]);
                              },
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.pinkAccent,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, left: 10, right: 8, bottom: 8),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.84,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.deepPurple[200],
                                      ),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height: 5),
                                            Text("${this.rec[index].title}",
                                                style: TextStyle(
                                                  fontSize: 24,
                                                )),
                                            Text("${this.rec[index].date}",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                )),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Ingredients:",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  "${this.rec[index].ingredients}",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                  maxLines: 2,
                                                  softWrap: true,
                                                ),
                                              ],
                                            ),
                                            Text("Course:",
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
                }),
          ),
        ],
      ),
    );
  }

  void _delete(BuildContext context, Recipe_info rec) async {
    int result = await dbhelper.deleteRecipe(rec.id);
    if (result != 0) {
      updateRecipeView();
    }
  }

  void updateRecipeView() {
    final Future<Database> dbFuture = dbhelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Recipe_info>> recListFuture = dbhelper.getRecipeList();
      recListFuture.then((rec) {
        setState(() {
          this.rec = rec;
          this.count = rec.length;
          debugPrint('COUNT IS ${this.count}');
        });
      });
    });
  }

  void navigateToDetail(Recipe_info rec) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return RecipeCard(rec);
    }));

    if (result == true) {
      updateRecipeView();
    }
  }
}
