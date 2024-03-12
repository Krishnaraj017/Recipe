class RecipeResponse {
  List<DetectObject> detectObjects;
  String detectObjectsNames;
  Map<String, Recipe> recommendedRecipes;

  RecipeResponse({
    required this.detectObjects,
    required this.detectObjectsNames,
    required this.recommendedRecipes,
  });

  factory RecipeResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> objectsJson = json['detect_objects'] ?? [];
    List<DetectObject> objects =
        objectsJson.map((obj) => DetectObject.fromJson(obj)).toList();

    Map<String, dynamic> recipesJson = json['recommended_recipes'] ?? {};
    Map<String, Recipe> recipes =
        recipesJson.map((key, value) => MapEntry(key, Recipe.fromJson(value)));

    return RecipeResponse(
      detectObjects: objects,
      detectObjectsNames: json['detect_objects_names'] ?? "",
      recommendedRecipes: recipes,
    );
  }
}

class DetectObject {
  String name;
  double confidence;

  DetectObject({
    required this.name,
    required this.confidence,
  });

  factory DetectObject.fromJson(Map<String, dynamic> json) {
    return DetectObject(
      name: json['name'] ?? "",
      confidence: json['confidence'] != null
          ? double.parse(json['confidence'].toString())
          : 0.0,
    );
  }
}

class Recipe {
  String recipe;
  String score;
  String srno;
  String url;

  Recipe({
    required this.recipe,
    required this.score,
    required this.srno,
    required this.url,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      recipe: json['recipe'] ?? "",
      score: json['score'] ?? "",
      srno: json['Srno'] ?? "",
      url: json['url'] ?? "",
    );
  }
}
