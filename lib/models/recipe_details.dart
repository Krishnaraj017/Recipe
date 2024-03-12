class RecipeDetails {
  int srno;
  String recipeName;
  List<String> ingredients;
  int prepTimeInMins;
  int cookTimeInMins;
  int totalTimeInMins;
  int servings;
  String cuisine;
  String course;
  String diet;
  String instructions;
  String recipeUrl;
  List<String> ingredientsParsed;

  RecipeDetails({
    required this.srno,
    required this.recipeName,
    required this.ingredients,
    required this.prepTimeInMins,
    required this.cookTimeInMins,
    required this.totalTimeInMins,
    required this.servings,
    required this.cuisine,
    required this.course,
    required this.diet,
    required this.instructions,
    required this.recipeUrl,
    required this.ingredientsParsed,
  });

  factory RecipeDetails.fromJson(Map<String, dynamic> json) {
    List<dynamic> ingredientsJson = json['ingredients'] ?? [];
    List<String> ingredients = ingredientsJson.cast<String>();

    List<dynamic> ingredientsParsedJson = json['ingredients_parsed'] ?? [];
    List<String> ingredientsParsed = ingredientsParsedJson.cast<String>();

    return RecipeDetails(
      srno: json['Srno'] ?? 0,
      recipeName: json['recipe_name'] ?? "",
      ingredients: ingredients,
      prepTimeInMins: json['PrepTimeInMins'] ?? 0,
      cookTimeInMins: json['CookTimeInMins'] ?? 0,
      totalTimeInMins: json['TotalTimeInMins'] ?? 0,
      servings: json['Servings'] ?? 0,
      cuisine: json['Cuisine'] ?? "",
      course: json['Course'] ?? "",
      diet: json['Diet'] ?? "",
      instructions: json['Instructions'] ?? "",
      recipeUrl: json['recipe_urls'] ?? "",
      ingredientsParsed: ingredientsParsed,
    );
  }
}
