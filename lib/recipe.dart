import 'package:flutter/material.dart';
import 'package:recipe_app/homepage.dart';
import 'package:recipe_app/models/recipe_database.dart';
import 'package:recipe_app/utils/database_helper.dart';
import 'package:intl/intl.dart';

class RecipeCard extends StatefulWidget {
  final Recipe_info recipe;
  const RecipeCard(this.recipe);

  @override
  _RecipeCardState createState() {
    return _RecipeCardState(this.recipe);
  }
}

class _RecipeCardState extends State<RecipeCard> {
  DatabaseHelper dbhelper = DatabaseHelper();
  Recipe_info rec;
  _RecipeCardState(this.rec);

  TextEditingController titleController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController recipeController = TextEditingController();
  TextEditingController cuisineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = rec.title;
    ingredientsController.text = rec.ingredients;
    recipeController.text = rec.recipe;
    cuisineController.text = rec.cuisine;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.save_alt),
              onPressed: () {
                setState(() {
                  _save();
                });
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.deepPurple[50],
            ),
            child: Wrap(
              children: <Widget>[
                Stack(children: <Widget>[
                  _section(5.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 14, right: 14, top: 8),
                    child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: titleController,
                        onChanged: (value) => {
                              updateTitle(),
                              //dbhelper.colTitle = value,
                            }),
                  ),
                ]),
                Stack(children: [
                  _section(3.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 14, right: 14, top: 8),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: ingredientsController,
                      onChanged: (value) => updateIngredients(),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.breakfast_dining),
                      ),
                    ),
                  ),
                ]),
                Stack(children: [
                  _section(1.5),
                  Padding(
                    padding: const EdgeInsets.only(left: 14, right: 14, top: 8),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: recipeController,
                      onChanged: (value) => updateRecipe(),
                      decoration:
                          InputDecoration(prefixIcon: Icon(Icons.local_dining)),
                    ),
                  ),
                ]),
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

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Update the entries
  void updateTitle() {
    rec.title = titleController.text;
  }

  void updateIngredients() {
    rec.ingredients = ingredientsController.text;
  }

  void updateRecipe() {
    rec.recipe = recipeController.text;
  }

  void updateCuisine() {
    rec.cuisine = cuisineController.text;
  }

  // Save data to database
  void _save() async {
    moveToLastScreen();

    rec.date = DateFormat.yMMMd().format(DateTime.now());

    var result;
    if (rec.id != null) {
      // Case 1: Update operation
      result = await dbhelper.updateRecipe(rec);
      debugPrint("Updated recipe");
    } else {
      // Case 2: Insert Operation
      result = await dbhelper.insertRecipe(rec);
      debugPrint("Saved recipe");
    }

    if (result != 0) {
      // Success
      debugPrint('Recipe Saved Successfully');
    } else {
      // Failure
      debugPrint('Problem Saving Recipe');
    }
  }

  void _delete() async {
    if (rec.id == null) {
      debugPrint('No Todo was deleted');
      return;
    }

    int result = await dbhelper.deleteRecipe(rec.id);
    if (result != 0) {
      // Success
      debugPrint('Recipe Deleted Successfully');
    } else {
      // Failure
      debugPrint('Problem Deleting Recipe');
    }
  }
}
