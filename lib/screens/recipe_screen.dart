import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe_details.dart'; // Import your RecipeDetails model

class RecipeDetailsScreen extends StatelessWidget {
  final RecipeDetails recipeDetails;

  const RecipeDetailsScreen({Key? key, required this.recipeDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recipe Name: ${recipeDetails.recipeName}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Prep Time: ${recipeDetails.prepTimeInMins} mins'),
            Text('Cook Time: ${recipeDetails.cookTimeInMins} mins'),
            Text('Total Time: ${recipeDetails.totalTimeInMins} mins'),
            Text('Servings: ${recipeDetails.servings}'),
            Text('Cuisine: ${recipeDetails.cuisine}'),
            Text('Course: ${recipeDetails.course}'),
            Text('Diet: ${recipeDetails.diet}'),
            Text('Instructions: ${recipeDetails.instructions}'),
            Image.network(
              recipeDetails.recipeUrl, // Use the recipe URL to load the image
              height: 100, // Set the height of the image
              width: 100, // Set the width of the image
              fit: BoxFit.cover, // Adjust the image to cover the entire space
            ),
          ],
        ),
      ),
    );
  }
}
