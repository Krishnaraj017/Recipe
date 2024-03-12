import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/models/item_detect_response.dart';
import 'package:recipe_app/models/recipe_details.dart';
import 'package:recipe_app/screens/recipe_screen.dart';

class DetectedItemScreen extends StatelessWidget {
  final RecipeResponse response;

  const DetectedItemScreen({Key? key, required this.response}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<RecipeDetails> getRecipe({required srno}) async {
      try {
        final response = await http.get(
          Uri.parse('http://127.0.0.1:8000/recipe/$srno'),
        );
        if (response.statusCode == 200) {
          final recipeDetailsJson = json.decode(response.body);
          final recipeDetails = RecipeDetails.fromJson(recipeDetailsJson);
          return recipeDetails;
        } else {
          throw Exception('Failed to load recipe details');
        }
      } catch (e) {
        print('Error: $e');
        throw e; // Rethrow the exception
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommended Recipes'),
      ),
      body: ListView.builder(
        itemCount: response.recommendedRecipes.length,
        itemBuilder: (context, index) {
          var recipe = response.recommendedRecipes.values.elementAt(index);
          return Card(
            elevation: 4,
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                recipe.recipe,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Score: ${recipe.score}'),
                  const SizedBox(height: 4),
                  Text('Srno: ${recipe.srno}'),
                  const SizedBox(height: 4),
                  Image.network(
                    recipe.url,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              onTap: () async {
                try {
                  var recipeDetails = await getRecipe(srno: recipe.srno);
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RecipeDetailsScreen(recipeDetails: recipeDetails),
                    ),
                  );
                } catch (e) {
                  // Handle error
                  print('Error: $e');
                }
              },
            ),
          );
        },
      ),
    );
  }
}
