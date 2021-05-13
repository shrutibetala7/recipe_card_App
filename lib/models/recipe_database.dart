class Recipe_info {
  int recipe_id;
  String _title;
  String _recipe;
  String _cuisine;
  int _calories;
  String _ingredients;
  String _date;

  Recipe_info(this._title,
      [this._date,
      this._calories,
      this._cuisine,
      this._ingredients,
      this._recipe]);
  Recipe_info.withId(this.recipe_id, this._title, this._date,
      [this._calories, this._cuisine, this._ingredients, this._recipe]);

  // setting up the get function
  int get id => recipe_id;
  String get title => _title;
  String get recipe => _recipe;
  String get cuisine => _cuisine;
  int get calories => _calories;
  String get ingredients => _ingredients;
  String get date => _date;

  //setting up the set function
  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set recipe(String newRecipe) {
    this._recipe = newRecipe;
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set calories(int newCalories) {
    this._calories = newCalories;
  }

  set ingredients(String newIngredients) {
    this._ingredients = newIngredients;
  }

  set cuisine(String newCuisine) {
    if (newCuisine.length <= 20) {
      this._cuisine = newCuisine;
    }
  }

//convert recipe_info object into map object

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = recipe_id;
    map['title'] = _title;
    map['cuisine'] = _cuisine;
    map['recipe'] = _recipe;
    map['ingredients'] = _ingredients;
    map['date'] = _date;
    map['calories'] = _calories;

    return map;
  }

//convert map object to recipe_info object
  Recipe_info.fromMapObject(Map<String, dynamic> map) {
    this.recipe_id = map['id'];
    this._title = map['title'];
    this._cuisine = map['cuisine'];
    this._recipe = map['recipe'];
    this._ingredients = map['ingredients'];
    this._date = map['date'];
    this._calories = map['calories'];
  }
}
