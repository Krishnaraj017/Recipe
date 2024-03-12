import 'package:equatable/equatable.dart';
import 'package:recipe_app/models/item_detect_response.dart';
import 'package:recipe_app/models/recipe_details.dart';

abstract class SendPicture extends Equatable {
  const SendPicture();
}

class SendPictureInitial extends SendPicture {
  @override
  List<Object?> get props => [];
}

class SendPictureLoading extends SendPicture {
  @override
  List<Object?> get props => [];
}

class SendPictureSuccess extends SendPicture {
  final RecipeResponse recipeResponse;
  const SendPictureSuccess(this.recipeResponse);
  @override
  List<Object?> get props => [recipeResponse];
}

class GetRecipeSuccess extends SendPicture {
  final RecipeDetails recipeDetails;
  const GetRecipeSuccess(this.recipeDetails);
  @override
  List<Object?> get props => [recipeDetails];
}

class SendPictureError extends SendPicture {
  final String message;
  const SendPictureError(this.message);

  @override
  List<Object?> get props => [message];
}
